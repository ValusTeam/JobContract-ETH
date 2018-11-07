pragma solidity 0.4.24;

contract JobContractParent
{
    address owner;
    address public addressOfChild;
    
    constructor() public
    {
        owner = msg.sender;
    }
    
    function createJobContract(uint _budgetWei, address _contractor) public
    {
        address _jobOwner = msg.sender;
        JobContract childJobContract = new JobContract(_budgetWei, _contractor, _jobOwner);
        // get address of deployed contract
        addressOfChild = childJobContract;
    }
}


contract JobContract
{
    uint public budgetWei;
    address public owner;
    address public contractor;
    int8 public status;
    bool public refundApproved;
    // 0- nothing has been payed yet, 1- owner has put the deposit thus the contract is locked, 2- contractor has completed the work, 3 - owner confirmed it and job is finished, 4- refunded and canceled
    // we could add another status for contractor acepting the contract if possibly he changed his mind
    // we could also do this with mapping and without status
    
    // adding _jobOwner as we have to pass it from the parent contract as else the parent contract is the owner and we do not want that!
    constructor(uint _budgetWei, address _contractor, address _jobOwner) public
    {
        budgetWei=_budgetWei;
        owner = _jobOwner;
        require(owner!=_contractor);
        contractor = _contractor;
        status = 0;
        refundApproved = false;
    }
    
    modifier onlyOwner
    {
        require(msg.sender==owner);
        _;
    }
    
    modifier onlyContractor
    {
        require(msg.sender==contractor);
        _;
    }
    
    function lockOwnerFunds() payable public onlyOwner
    {
        require(contractor!=owner);
        require(status==0);
        require(budgetWei==msg.value);
        // funds locked, work in progress...
        status=1;
    }
    
    function finishJob() public onlyContractor
    {
        require(contractor!=owner);
        require(status==1);
        // contractor finished the job...
        status=2;
    }
    
    function confirmPayment() public onlyOwner
    {
        require(contractor!=owner);
        require(status==2);
        // owner confirms that the work is ok and agrees to confirm payment 
        // could use selfdestruct(contractor) here? https://ethereum.stackexchange.com/questions/315/why-are-suicides-used-in-contract-programming
        //posiljanje iz contracta
        contractor.transfer(budgetWei);
        status=3;
    }
    
    // disputes!
    function returnFunds() public onlyOwner
    {
        // if there is some sort of a dispute return locked funds only when work in progress? 
        require(status!=3);
        require(status!=4);
        require(refundApproved==true);
        
        msg.sender.transfer(budgetWei);
        status=4;
    }
    
    // function for agreeing to refund from the side of contractor
    function approveRefound() public onlyContractor
    {   
        // but this can be used to extort the owner as it prevents him in refunding!
        refundApproved = true;
    }
        
}
