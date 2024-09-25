pragma solidity 0.8.26;

contract FaceMash {
    
    struct FashionItem {
        string name;
        string description;
        uint256 voteCount;
        address owner;
    }

    FashionItem[] public fashionItems;

    mapping(uint256 => mapping(address => bool)) public hasVoted;  // Keeps track of which user has voted for which item
    mapping(address => bool) public userSubmitted;  // Track if a user has already submitted an item

    // Modifier to ensure the item exists
    modifier validItem(uint256 itemId) {
        require(itemId < fashionItems.length, "Invalid item ID");
        _;
    }

    // Modifier to ensure the user hasn't already submitted an item
    modifier onlyOneSubmission() {
        require(!userSubmitted[msg.sender], "You have already submitted an item");
        _;
    }

    // Event triggered when a new item is submitted
    event FashionItemSubmitted(uint256 itemId, string name, string description, address owner);

    // Event triggered when an item is voted on
    event VotedOnFashionItem(uint256 itemId, address voter);

    // Submit a new fashion item
    function submitItem(string memory name, string memory description) public onlyOneSubmission {
        FashionItem memory newItem = FashionItem({
            name: name,
            description: description,
            voteCount: 0,
            owner: msg.sender
        });

        fashionItems.push(newItem);
        userSubmitted[msg.sender] = true;

        emit FashionItemSubmitted(fashionItems.length - 1, name, description, msg.sender);
    }

    // Vote on a fashion item by its index
    function voteOnItem(uint256 itemId) public validItem(itemId) {
        require(!hasVoted[itemId][msg.sender], "You have already voted for this item");

        fashionItems[itemId].voteCount += 1;
        hasVoted[itemId][msg.sender] = true;

        emit VotedOnFashionItem(itemId, msg.sender);
    }

    // Get the details of a specific fashion item by returning the entire FashionItem struct
    function getItem(uint256 itemId) public view validItem(itemId) returns (FashionItem memory) {
        return fashionItems[itemId];
}


    // Get the most popular item based on votes
    function getTopVotedItem() public view returns (FashionItem memory) {
        uint256 highestVotes = 0;
        uint256 topItemId = 0;

        for (uint256 i = 0; i < fashionItems.length; i++) {
            if (fashionItems[i].voteCount > highestVotes) {
                highestVotes = fashionItems[i].voteCount;
                topItemId = i;
            }
        }

        FashionItem memory topItem = fashionItems[topItemId];
        return fashionItems[topItemId];
    }

    // Get the total number of fashion items submitted
    function getTotalItems() public view returns (uint256) {
        return fashionItems.length;
    }
}
