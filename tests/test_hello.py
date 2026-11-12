import pytest

from app.hello import greet


def test_greet_returns_greeting_for_name() -> None:
    assert greet(" Ada ") == "Hello, Ada!"


def test_greet_rejects_blank_name() -> None:
    with pytest.raises(ValueError, match="blank"):
        greet("   ")
