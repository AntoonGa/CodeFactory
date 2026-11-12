"""Placeholder module. It proves the toolchain works. Replace it with real code."""


def greet(name: str) -> str:
    """Return a greeting for `name`. Raise ValueError when `name` is blank."""
    if not name.strip():
        raise ValueError("name must not be blank")
    return f"Hello, {name.strip()}!"
