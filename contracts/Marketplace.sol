// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

contract Marketplace{
    
    /**
     * Declare enum name ShippingStatus
     */
    enum ShippingStatus {
        Pending,
        Shipped,
        Delivered
    }
    
    /**
     * contract's status
     */
    ShippingStatus private status; 

    /**
     *  owner's adress
     */
    address private owner;

    /**
     * customer's adress
     */
    address private customer;

    /**
     * Event send in shipped method
     */
    event MissionComplete(string message);
    constructor (address _customer){
        status = ShippingStatus.Pending;
        customer = _customer;
        owner = msg.sender;
    }
    
    /**
     * Apply condition for owner only
     */
    modifier ownerOnly(){
        require(msg.sender == owner, "You dont allowed to see that !");
        _;
    }

    /**
     * Apply condition for customer only
     */
    modifier costumerOnly(){
        require(msg.sender == customer, "You dont allowed to see that !");
        _;
    }

    /**
     * Method to change status into "shipped"
     */
    function shipped() public ownerOnly{
        status = ShippingStatus.Shipped;
        emit MissionComplete("Package has been shipped");
    }
    /**
     * Method to change status into "delivered"
     */
    function delivered () public ownerOnly {
        status = ShippingStatus.Delivered;
    }

    /**
     * Method to get status only by owner
     */
    function getStatus() public ownerOnly view returns (ShippingStatus) {
        return status;
    }

    /**
     * Method to get status only by customer and by this transaction
     */
    function getStatusCustomer() public costumerOnly payable returns (ShippingStatus){
        require(msg.value > 0, "You dont any money on wellet !");
        return status;
    }
}