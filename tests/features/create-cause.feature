Feature: Create cause

    Scenario: we cannot create a cause without client
        When I post to "/causes"
        """
        {"wording": "foo"}
        """
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"

    Scenario: wording is required
        I fill in header "X-Customer-Id" with "5"
        When I post to "/causes"
        """
        {"wordingAA": "foo"}
        """
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "'wording' is a required property"

    Scenario: creation of cause
        I fill in header "X-Customer-Id" with "5"
        When I post to "/causes" with:
        """
        {"wording": "foo"}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "cause.wording" should be "foo"

    Scenario: Cause are created
        I fill in header "X-Customer-Id" with "5"
        Given I post to "/causes" with:
        """
        {"wording": "foo"}
        """
        When I get "/causes"
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "causes" should have a size of 1
        And the field "causes.0.wording" should be "foo"
