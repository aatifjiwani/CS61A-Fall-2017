def twenty_seventeen():
    """Come up with the most creative expression that evaluates to 2017,
    using only numbers and the +, *, and - operators.

    >>> twenty_seventeen()
    2017
    """
    return (2 + (0 + 1) * 7) * (2 + (0 + 1)  *6 ) * (2 + (0 + 1)  * 5) \
           * ((2 * 0 * 1) + 4) + 1

print(twenty_seventeen())
