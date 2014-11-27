Feature: Create Channel

    Scenario: we cannot create severity without client
        When I post to "/channels" with:
        """
        {"name": "foo", "max_size": 500, "content_type": "text/type"}
        """
        Then the status code should be "400"

    Scenario: creation of channel
        I fill in header "X-Customer-Id" with "5"
        When I post to "/channels" with:
        """
        {"name": "foo", "max_size": 500, "content_type": "text/type"}
        """
        Then the status code should be "201"
        And the header "Content-Type" should be "application/json"
        And the field "channel.name" should be "foo"
        And the field "channel.max_size" should be 500

    Scenario: We can't create a channel without name, max_size and
        I fill in header "X-Customer-Id" with "5"
        When I post to "/channels" with:
        """
        {"name": "foo", "max_size": 500}
        """
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"






