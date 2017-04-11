<?php

class PagarMe_Core_Model_Sdk_Adapter extends Mage_Core_Model_Abstract
{
    /**
     * @var \PagarMe\Sdk\PagarMe
     */
    private $pagarMeSdk;

    public function _construct()
    {
        parent::_construct();

        $headers = [
            'User-Agent' => sprintf(
                'Magento/%s PagarMe/%s PHP/%s',
                Mage::getVersion(),
                Mage::getConfig()->getNode()->modules->PagarMe_Core->version,
                phpversion()
            )
        ];

        $this->pagarMeSdk = new \PagarMe\Sdk\PagarMe(
            Mage::getStoreConfig('payment/pagarme_settings/api_key'),
            null,
            $headers
        );
    }

    /**
     * @return \PagarMe\Sdk\PagarMe
     */
    public function getPagarMeSdk()
    {
        return $this->pagarMeSdk;
    }
}
