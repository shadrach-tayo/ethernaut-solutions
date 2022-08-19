### Level 8 Vault
To unlock this contract, Inspect the storage of the Vault contract

## Prerequisites
- Layout of storage variables in solidity
- Reading a storage slot in a contract 

## solution
To read the value of password in storage, you have to know where it is store.
```solidity
bytes32 private password;
```
The password is a bytes32 data type which means it will occupy a whole slot in storage.

So the slot is 1, To read the slot 1 in storage we can use web3.js as follow: 
```javascript
password = await web3.eth.getStorageAt(contract.address, 1)
```

To read contract storage in your foundry project use cast
```javascript
cast storage [contract.address] [slot]
cast storage 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 1
```

Call unlock with the value ov password
```javascript
await contract.unlock();
```
