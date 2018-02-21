from os import path
import json
from nose.tools import *
from nose import with_setup
from chaos.utils import client_token_is_allowed, get_clients_tokens
from chaos.exceptions import Unauthorized

correct_file =  path.dirname(path.realpath(__file__)) + '/fixtures/clients_tokens.json'
wrong_file =  path.dirname(path.realpath(__file__)) + '/fixtures/foo.json'

def test_client_token_file_doesnt_exist():
    assert get_clients_tokens(wrong_file) == None

def test_client_with_first_token_is_allowed():
    clients_tokens = get_clients_tokens(correct_file)
    assert client_token_is_allowed(clients_tokens, 'transilien', '9bf5')

def test_client_with_second_token_is_allowed():
    clients_tokens = get_clients_tokens(correct_file)
    assert client_token_is_allowed(clients_tokens, 'transilien', '9bf6')

@raises(Unauthorized)
def test_client_with_wrong_token_is_not_allowed():
    clients_tokens = get_clients_tokens(correct_file)
    client_token_is_allowed(clients_tokens, 'transilien', '1')

@raises(Unauthorized)
def test_wrong_client_is_not_allowed():
    clients_tokens = get_clients_tokens(correct_file)
    client_token_is_allowed(clients_tokens, 'centre', '9bf5')