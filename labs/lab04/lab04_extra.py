from lab04 import *

# Q13
def flatten(lst):
    """Returns a flattened version of lst.

    >>> flatten([1, 2, 3])     # normal list
    [1, 2, 3]
    >>> x = [1, [2, 3], 4]      # deep list
    >>> flatten(x)
    [1, 2, 3, 4]
    >>> x = [[1, [1, 1]], 1, [1, 1]] # deep list
    >>> flatten(x)
    [1, 1, 1, 1, 1, 1]
    """
    "*** YOUR CODE HERE ***"
    new_list = []
    for x in lst:
        if type(x) == list:
            new_list += flatten(x)
        else:
            new_list += [x]

    return new_list

# Q14
def merge(lst1, lst2):
    """Merges two sorted lists.

    >>> merge([1, 3, 5], [2, 4, 6])
    [1, 2, 3, 4, 5, 6]
    >>> merge([], [2, 4, 6])
    [2, 4, 6]
    >>> merge([1, 2, 3], [])
    [1, 2, 3]
    >>> merge([5, 7], [2, 4, 6])
    [2, 4, 5, 6, 7]
    """
    "*** YOUR CODE HERE ***"
    if len(lst1) == 0:
        return lst2
    elif len(lst2) == 0:
        return lst1
    else:
        new_list = []
        z = 0
        for x in lst1:
            for y in range(z, len(lst2)):
                if lst2[y] < x:
                    new_list += [lst2[y]]
                    z += 1
            new_list += [x]
    
        return new_list
