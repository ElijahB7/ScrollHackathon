pragma solidity ^0.8.26;

contract AdvancedMarketplace {

    struct Items {
        uint256 itemId;
        string itemName;
        bool saleId;
        address seller;
        uint256 price;  // Sale price of the item (in Wei)
    }

    uint256 public itemCounter;

    mapping(uint256 => Items) public itemStorage;

    // Function to create an item
    function createItem(uint256 _itemId, string memory _itemName) external {
        // Check if the itemId already exists
        require(itemStorage[_itemId].itemId == 0, "Item ID already exists");

        // Create a new item struct and save it in memory first
        Items memory newItem = Items({
            itemId: _itemId,
            itemName: _itemName,
            saleId: false,     // Initially not for sale
            seller: msg.sender,
            price: 0           // Price is 0 until set by the seller
        });

        // Store the new item in the mapping
        itemStorage[_itemId] = newItem;

        // Increment the item counter
        itemCounter++;
    }

    // Function to allow the owner to sell an item
    function sellItem(uint256 _itemId, uint256 _price) external {
        // Ensure the item exists
        require(itemStorage[_itemId].itemId != 0, "Item does not exist");

        // Ensure that the caller is the owner of the item
        require(itemStorage[_itemId].seller == msg.sender, "You are not the owner");

        // Set the item as available for sale
        itemStorage[_itemId].saleId = true;

        // Set the sale price for the item (make sure it's in Wei)
        itemStorage[_itemId].price = _price;
    }

    // Function to allow someone to buy an item
    function buyItem(uint256 _itemId) external payable {
        // Ensure the item exists
        require(itemStorage[_itemId].itemId != 0, "Item does not exist");

        // Ensure the item is for sale
        require(itemStorage[_itemId].saleId == true, "Item is not for sale");

        // Ensure the buyer has sent the correct amount (in Wei)
        require(msg.value == itemStorage[_itemId].price, "Incorrect ETH amount sent");

        // Get the seller's address
        address seller = itemStorage[_itemId].seller;

        // Transfer ownership to the buyer (msg.sender)
        itemStorage[_itemId].seller = msg.sender;

        // Mark the item as not for sale
        itemStorage[_itemId].saleId = false;

        // Reset the sale price
        itemStorage[_itemId].price = 0;

        // Transfer the sale price to the original seller
        payable(seller).transfer(msg.value);
    }
}
