Feature: One Step Checkout Pagar.me
    As a customer
    I want to use PagarMe Checkout
    And One Step Checkout
    To make purchase

    Scenario: Make a purchase by boleto without discount
        Given I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        And place order
        Then the purchase must be created with success
        And a link to boleto must be provided

    Scenario Outline: Display discount on checkout when a fixed discount was applied
        Given fixed "<boleto_discount>" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        Then the absolute discount of "<boleto_discount>" must be informed on checkout
        Examples:
        | boleto_discount |
        | 10.5            |
        | 1.23            |

    Scenario Outline: Display discount on checkout when a percentual discount was applied
        Given percentual "<boleto_discount>" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        Then the percentual discount of "<boleto_discount>" must be informed on checkout
        Examples:
        | boleto_discount |
        | 13.37           |
        | 42              |

    Scenario: Make a purchase by boleto with fixed discount
        Given fixed "10.5" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        And place order
        Then the purchase must be created with success
        And a link to boleto must be provided

    Scenario: Make a purchase by boleto with a percentual discount
        Given percentual "13.37" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        And place order
        Then the purchase must be created with success
        And a link to boleto must be provided

    Scenario Outline: Display discount on checkout when a fixed discount was applied
        Given fixed "<boleto_discount>" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        Then the absolute discount of "<boleto_discount>" must be informed on checkout
        Examples:
        | boleto_discount |
        | 10.5            |
        | 1.23            |

    Scenario Outline: Display discount on checkout when a percentual discount was applied
        Given percentual "<boleto_discount>" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        Then the percentual discount of "<boleto_discount>" must be informed on checkout
        Examples:
        | boleto_discount |
        | 13.37           |
        | 42              |

    Scenario: Make a purchase by boleto with fixed discount
        Given fixed "10.5" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        And place order
        Then the purchase must be created with success
        And a link to boleto must be provided

    Scenario: Make a purchase by boleto with a percentual discount
        Given percentual "13.37" discount for boleto payment is provided
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "Boleto" with "1" installments
        And place order
        Then the purchase must be created with success
        And a link to boleto must be provided

    Scenario Outline: Display interest rate when applied
        Given "<rate>" interest rate for multi installment payment
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment using "<number>" installments
        Then the percentual interest of "<rate>" over "<number>" installments must be informed on checkout
        Examples:
        | rate  | number    |
        | 3     | 9         |
        | 10.1  | 3         |

    Scenario: Make a purchase by credit card with multiple installments
        Given "4.2" interest rate for multi installment payment
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment using "5" installments
        And place order
        Then the purchase must be created with success

    Scenario: Make a purchase by credit card without fee
        Given "0" interest rate for multi installment payment
        And I am on checkout page using Inovarti One Step Checkout
        When I confirm payment using "5" installments
        And place order
        Then the purchase must be created with success

    Scenario: Hide pagarme checkout button after success
        Given I am on checkout page using Inovarti One Step Checkout
        When I confirm payment
        Then The button that opens pagarme checkout must be hidden

    Scenario: Show alert when payment information is not provided
        Given I am on checkout page using Inovarti One Step Checkout
        When select Pagar.me Checkout as payment method
        And click on place order button
        Then an alert box must be displayed


    @showInfo
    Scenario Outline: Confirm the selected payment method
        Given I am on checkout page using Inovarti One Step Checkout
        When I confirm payment via "<payment_method>" with "<installments>" installments
        Then I should see payment method equals to "<payment_method_expected>"
        And installments equals to "<installments>"
        Examples:
        |   payment_method  | installments | payment_method_expected |
        | Boleto bancário   | 1            | Boleto                  |
        | Cartão de crédito | 1            | Cartão de Crédito       |
        | Cartão de crédito | 6            | Cartão de Crédito       |
