Feature: command line support

  As a user
  In order to be able to verify IBAN from a CRM
  I want iban-check to provide a reliable command line

  Scenario: Calling without any parameter
    When I run `iban-check`
    Then the exit status should be 1
    And the output should contain:
    """
    Exactly one argument expected
    """

  Scenario: Calling with a valid IBAN between quotes
    When I run `iban-check "PL27 1140 2004 0000 3002 0135 5387"`
    Then the exit status should be 0
    And the output should contain:
    """
    Valid IBAN
    """

  Scenario: Calling with a valid IBAN with no spaces and no quotes
    When I run `iban-check PL27114020040000300201355387`
    Then the exit status should be 0
    And the output should contain:
    """
    Valid IBAN
    """

  Scenario: Calling with an invalid IBAN
    When I run `iban-check "PL27 1140 2004 0000 3002 0135 5388"`
    Then the exit status should be 1
    And the output should contain:
    """
    Invalid IBAN
    """
  
  Scenario: Calling with an invalid country code
    When I run `iban-check "Z927 1140 2004 0000 3002 0135 5388"`
    Then the exit status should be 1
    And the output should contain:
    """
    Invalid country
    """  
