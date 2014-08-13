<?php
/**
 *
 * @category   Inovarti
 * @package    Inovarti_Pagarme
 * @author     Suporte <suporte@inovarti.com.br>
 */
class Inovarti_Pagarme_Block_Form_Cc extends Mage_Payment_Block_Form_Cc
{
	const MIN_INSTALLMENT_VALUE = 5;

    protected function _construct()
    {
        parent::_construct();
        $this->setTemplate('pagarme/form/cc.phtml');
    }

    public function getInstallmentsAvailables(){
    	$maxInstallments = (int)Mage::getStoreConfig('payment/pagarme_cc/max_installments');
    	$minInstallmentValue = (float)Mage::getStoreConfig('payment/pagarme_cc/min_installment_value');
        $interestRate = (float)Mage::getStoreConfig('payment/pagarme_cc/interest_rate');
        $freeInstallments = (int)Mage::getStoreConfig('payment/pagarme_cc/free_installments');
    	if ($minInstallmentValue < self::MIN_INSTALLMENT_VALUE) {
    		$minInstallmentValue = self::MIN_INSTALLMENT_VALUE;
    	}

    	$quote = Mage::helper('checkout')->getQuote();
    	$total = $quote->getGrandTotal();

    	$n = floor($total / $minInstallmentValue);
    	if ($n > $maxInstallments) {
    		$n = $maxInstallments;
    	} elseif ($n < 1) {
    		$n = 1;
    	}

        $data = new Varien_Object();
        $data->setEncryptionKey(Mage::helper('pagarme')->getEncryptionKey())
            ->setAmount(Mage::helper('pagarme')->formatAmount($total))
            ->setInterestRate($interestRate)
            ->setMaxInstallments($n)
            ->setFreeInstallments($freeInstallments) // optional
            ;

        $response = Mage::getModel('pagarme/api')->calculateInstallmentsAmount($data);
        $collection = $response->getInstallments();

        $installments = array();
        foreach ($collection as $item) {
            if ($item->getInstallment() == 1) {
                $label = $this->__('Pay in full - %s', $quote->getStore()->formatPrice($item->getInstallmentAmount()/100, false));
            } else {
                $label = $this->__('%sx - %s', $item->getInstallment(), $quote->getStore()->formatPrice($item->getInstallmentAmount()/100, false)) . ' ';
                $label .= $item->getInstallment() > $freeInstallments ? $this->__('monthly interest rate (%s)', $interestRate.'%') : $this->__('interest-free');
            }
            $installments[$item->getInstallment()] = $label;
        }
    	return $installments;
    }
}
