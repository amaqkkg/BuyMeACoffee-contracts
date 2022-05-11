//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// deployed to 0xcC67Fc3d763fE95A9F056444c7fbFF5C04E83Ad9 rinkeby
// updated 0x35AeD4b4ED9A60C6Ba5cbb99F05767e1cbd970eE rinkeby

import "hardhat/console.sol";

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo Struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends
    Memo[] memos;

    // Address of contract deployer
    address payable owner;

    // Deploy logic.
    constructor() {
        owner = payable(msg.sender);
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the coffee buyer
     */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "cant buy coffee with 0 eth");

        // add memo to the storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message);
    }

    /**
    * @dev send the entire balance stored in the contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));

    }

    /**
    * @dev retrieve all the memos received and stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;

    }

    /**
    *@dev change the owner address
     */
    function changeOwner(address _address) public {
        require(msg.sender == owner, "error, you are not the owner");
        owner = payable(_address);
    }

    /**
    *@dev see current owner address
     */
    function currentOwner() public view returns(address) {
        return owner;
    }
}
