Feature: Cause can be deleted
    Scenario: deletion of one cause without client in the header fails
        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |
        When I delete "/causes/7ffab230-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "400"

    Scenario: deletion of one cause with client absent in database fails
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "6"
        When I delete "/causes/7ffab230-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "404"

    Scenario: deletion of one cause
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "5"
        When I delete "/causes/7ffab230-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "204"
        And in the database for the cause "7ffab230-3d48-4eea-aa2c-22f8680230b6" the field "is_visible" should be "False"

    Scenario: deletion of non existing cause fail
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "5"
        When I delete "/causes/7ffab240-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "404"

    Scenario: deletion of invisible cause fail
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | False      | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "5"
        When I delete "/causes/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "404"

    Scenario: deletion of one cause
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "5"
        And I delete "/causes/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        When I get "/causes"
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "causes" should have a size of 1
        And the field "causes.0.wording" should be "weather"

    Scenario: delete cause with id not valid
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following causes in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | weather   | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | strike    | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "5"
        And I delete "/causes/AA-BB"
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"
