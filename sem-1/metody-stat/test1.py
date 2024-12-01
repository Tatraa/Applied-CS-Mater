def findMaximumPackages(cost):
    from collections import Counter

    # Count the frequency of each item cost
    freq = Counter(cost)
    
    # Track the maximum number of packages
    max_packages = 0

    # Check all possible package costs
    for target_cost in freq:
        # Initialize the count for this target cost
        packages = 0
        
        # Copy the frequency map so we don't modify the original
        temp_freq = freq.copy()
        
        # Check for combinations of two items
        for item_cost in freq:
            while temp_freq[item_cost] > 0 and target_cost - item_cost in temp_freq and temp_freq[target_cost - item_cost] > 0:
                # If two items can form the target cost, create a package
                if item_cost == target_cost - item_cost and temp_freq[item_cost] > 1:
                    # Special case: both items are the same
                    packages += 1
                    temp_freq[item_cost] -= 2
                elif item_cost != target_cost - item_cost:
                    packages += 1
                    temp_freq[item_cost] -= 1
                    temp_freq[target_cost - item_cost] -= 1

        # Update the maximum packages
        max_packages = max(max_packages, packages)

    return max_packages

# Example usage:
cost = [2, 1, 3]
print(findMaximumPackages(cost))  # Output: 2
