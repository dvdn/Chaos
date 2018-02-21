Feature: Severity can be deleted

    Background:
        I fill in header "X-Customer-Id" with "5"
        I fill in header "Authorization" with "d5b0148c-36f4-443c-9818-1f2f74a00be0"

    Scenario: deletion of one severity
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        When I delete "/severities/7ffab230-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "204"
        And in the database for the severity "7ffab230-3d48-4eea-aa2c-22f8680230b6" the field "is_visible" should be "False"

    Scenario: deletion of non existing severity fail
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        When I delete "/severities/7ffab240-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "404"

    Scenario: deletion of invisible severity fail
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | False      | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        When I delete "/severities/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        Then the status code should be "404"

    Scenario: deletion without client dans le header fails
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I remove header "X-Customer-Id"
        And I delete "/severities/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        When I get "/severities"
        Then the status code should be "400"

    Scenario: deletion with client dans le header absent in database fails
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        I fill in header "X-Customer-Id" with "6"
        And I delete "/severities/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        When I get "/severities"
        Then the status code should be "404"

    Scenario: deletion of one severity
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        And I delete "/severities/7ffab232-3d48-4eea-aa2c-22f8680230b6"
        When I get "/severities"
        Then the status code should be "200"
        And the header "Content-Type" should be "application/json"
        And the field "severities" should have a size of 1
        And the field "severities.0.wording" should be "blocking"
        And the field "severities.0.color" should be "#123456"

    Scenario: deletion of one severity by id invalid
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        And I delete "/severities/AA"
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"


    Scenario: deletion of one severity by id not in url
        Given I have the following clients in my database:
            | client_code   | created_at          | updated_at          | id                                   |
            | 5             | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | 7ffab229-3d48-4eea-aa2c-22f8680230b6 |

        Given I have the following severities in my database:
            | wording   | color   | created_at          | updated_at          | is_visible | id                                   |client_id                            |
            | blocking  | #123456 | 2014-04-02T23:52:12 | 2014-04-02T23:55:12 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
            | good news | #654321 | 2014-04-04T23:52:12 | 2014-04-06T22:52:12 | True       | 7ffab232-3d48-4eea-aa2c-22f8680230b6 |7ffab229-3d48-4eea-aa2c-22f8680230b6 |
        And I delete "/severities"
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"

        And I delete "/severities/"
        Then the status code should be "400"
        And the header "Content-Type" should be "application/json"
        And the field "error.message" should be "id invalid"

    Scenario: Client could delete only his severity

        Given I have the following clients in my database:
        | client_code   | created_at          | updated_at          | id                                   |
        | 7             | 2017-01-30T00:00:00 | 2017-01-30T00:00:00 | 5ffab229-3d48-4eea-aa2c-22f8680230b5 |
        | 8             | 2017-01-30T00:00:00 | 2017-01-30T00:00:00 | 6ffab229-3d48-4eea-aa2c-22f8680230b6 |
        Given I have the following severities in my database:
        | wording                | color   | created_at          | updated_at          | is_visible | id                                   | client_id                            |
        | severity_for_client_7  | #123456 | 2017-01-30T00:00:00 | 2017-01-30T00:00:00 | True       | 7ffab230-3d48-4eea-aa2c-22f8680230b6 | 5ffab229-3d48-4eea-aa2c-22f8680230b5 |
        | severity_for_client_8  | #ffffff | 2017-01-30T00:00:00 | 2017-01-30T00:00:00 | True       | 6ffab229-3d48-4eea-aa2c-22f8680230b6 | 6ffab229-3d48-4eea-aa2c-22f8680230b6 |

        I fill in header "X-Customer-Id" with "8"

        #when client_8 trys to remove a severity created by client_7 an arror should be created
        When I delete to "/severities/7ffab230-3d48-4eea-aa2c-22f8680230b6":
        Then the status code should be "404"
        And the header "Content-Type" should be "application/json"
        And the field "error" should have a size of 1
        And the field "error.message" should be "The severty with id 7ffab230-3d48-4eea-aa2c-22f8680230b6 does not exist for this client"

        #client_8 could be able to remove severity created by himself
        When I delete to "/severities/6ffab229-3d48-4eea-aa2c-22f8680230b6":
        Then the status code should be "204"
