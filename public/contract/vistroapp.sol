// SPDX-License-Identifier: MIT

//  https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/IERC165.sol
pragma solidity ^0.8.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol
pragma solidity ^0.8.0;

interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}


// File: @openzeppelin/contracts/utils/introspection/ERC165.sol
pragma solidity ^0.8.0;

abstract contract ERC165 is IERC165 {
 
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


pragma solidity ^0.8.0;
// conerts to ASCII
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";


    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

  
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }

   
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol

pragma solidity ^0.8.0;
//address functions
library Address {
  
    function isContract(address account) internal view returns (bool) {

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

 
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }


    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

  
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

  
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

   
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

   
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

   
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

  
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }


    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

  
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            
            if (returndata.length > 0) {
                

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/IERC721Metadata.sol

pragma solidity ^0.8.0;


//ERC-721 Token Standard
 
interface IERC721Metadata is IERC721 {
   
    function name() external view returns (string memory);

   
    function symbol() external view returns (string memory);

  
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol

pragma solidity ^0.8.0;



interface IERC721Receiver {

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol
pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol
pragma solidity ^0.8.0;

contract ERC721 is Context, ERC165, IERC721, IERC721Metadata {
    using Address for address;
    using Strings for uint256;

    string private _name;

    string private _symbol;

    mapping(uint256 => address) private _owners;

    mapping(address => uint256) private _balances;

    mapping(uint256 => address) private _tokenApprovals;

    mapping(address => mapping(address => bool)) private _operatorApprovals;
//coolection constructor
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

   
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }


    function balanceOf(address owner) public view virtual override returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balances[owner];
    }


    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

   
    function name() public view virtual override returns (string memory) {
        return _name;
    }

 
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

  
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

 
    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }

    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

   
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

   
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

  
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }
 
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }
  
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }

    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }


    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _owners[tokenId] != address(0);
    }
  
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ERC721.ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }
   
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

  
    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId);
        require(
            _checkOnERC721Received(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
        );
    }

 
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

   
    function _burn(uint256 tokenId) internal virtual {
        address owner = ERC721.ownerOf(tokenId);

        _beforeTokenTransfer(owner, address(0), tokenId);

        _approve(address(0), tokenId);

        _balances[owner] -= 1;
        delete _owners[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        _approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

  
    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
    }

    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}
}


pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}


// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

pragma solidity ^0.8.0;
// owner only commands
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

 //owner constructor
    constructor() {
        _setOwner(_msgSender());
    }

  
    function owner() public view virtual returns (address) {
        return _owner;
    }

   
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }


    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

 
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol

// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}

//https://github.com/1001-digital/erc721-extensions/blob/main/contracts/WithLimitedSupply.sol

pragma solidity ^0.8.0;


/// @author 1001.digital
/// @title A token tracker that limits the token supply and increments token IDs on each new mint.
abstract contract WithLimitedSupply {
    using Counters for Counters.Counter;

    /// @dev Emitted when the supply of this collection changes
    event SupplyChanged(uint256 indexed supply);

    // Keeps track of how many we have minted
    Counters.Counter private _tokenCount;

    /// @dev The maximum count of tokens this token tracker will hold.
    uint256 private _totalSupply;

    /// Instanciate the contract
    /// @param totalSupply_ how many tokens this collection should hold
    constructor (uint256 totalSupply_) {
        _totalSupply = totalSupply_;
    }

    /// @dev Get the max Supply
    /// @return the maximum token count
    function totalSupplyCheck() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /// @dev Get the current token count
    /// @return the created token count
    function tokenCount() public view returns (uint256) {
        return _tokenCount.current();
    }

    /// @dev Check whether tokens are still available
    /// @return the available token count
    function availableTokenCount() public view returns (uint256) {
        return totalSupplyCheck() - tokenCount();
    }

    /// @dev Increment the token count and fetch the latest count
    /// @return the next token id
    function nextToken() internal virtual returns (uint256) {
        uint256 token = _tokenCount.current();

        _tokenCount.increment();

        return token;
    }

    /// @dev Check whether another token is still available
    modifier ensureAvailability() {
        require(availableTokenCount() > 0, "No more tokens available");
        _;
    }

    /// @param amount Check whether number of tokens are still available
    /// @dev Check whether tokens are still available
    modifier ensureAvailabilityFor(uint256 amount) {
        require(availableTokenCount() >= amount, "Requested number of tokens not available");
        _;
    }

    /// Update the supply for the collection
    /// @param _supply the new token supply.
    /// @dev create additional token supply for this collection.
    function _setSupply(uint256 _supply) internal virtual {
        require(_supply > tokenCount(), "Can't set the supply to less than the current token count");
        _totalSupply = _supply;

        emit SupplyChanged(totalSupplyCheck());
    }
}

//https://github.com/1001-digital/erc721-extensions/blob/main/contracts/RandomlyAssigned.sol 

pragma solidity ^0.8.0;


/// @author 1001.digital
/// @title Randomly assign tokenIDs from a given set of tokens.
abstract contract RandomlyAssigned is WithLimitedSupply {
    // Used for random index assignment
    mapping(uint256 => uint256) private tokenMatrix;

    // The initial token ID
    uint256 private startFrom;

    /// Instanciate the contract
    /// @param _totalSupply how many tokens this collection should hold
    /// @param _startFrom the tokenID with which to start counting
    constructor (uint256 _totalSupply, uint256 _startFrom)
        WithLimitedSupply(_totalSupply)
    {
        startFrom = _startFrom;
    }

    /// Get the next token ID
    /// @dev Randomly gets a new token ID and keeps track of the ones that are still available.
    /// @return the next token ID
    function nextToken() internal override ensureAvailability returns (uint256) {
        uint256 maxIndex = totalSupplyCheck() - tokenCount();
        uint256 random = uint256(keccak256(
            abi.encodePacked(
                msg.sender,
                block.coinbase,
                block.difficulty,
                block.gaslimit,
                block.timestamp
            )
        )) % maxIndex;

        uint256 value = 0;
        if (tokenMatrix[random] == 0) {
            // If this matrix position is empty, set the value to the generated random number.
            value = random;
        } else {
            // Otherwise, use the previously stored number from the matrix.
            value = tokenMatrix[random];
        }

        // If the last available tokenID is still unused...
        if (tokenMatrix[maxIndex - 1] == 0) {
            // ...store that ID in the current matrix position.
            tokenMatrix[random] = maxIndex - 1;
        } else {
            // ...otherwise copy over the stored number to the current matrix position.
            tokenMatrix[random] = tokenMatrix[maxIndex - 1];
        }

        // Increment counts
        super.nextToken();

        return value + startFrom;
    }
}

/*  
                                                                                       
	

            ___ ___   __           __                        _______                 
           |   V   | |__| .-----. |  |_  .----. .-----.     |   _   | .-----. .-----.
           |.  |   | |  | |__ --| |   _| |   _| |  _  |     |.  _|  | |  _  | |  _  |
           |.  |   | |__| |_____| |____| |__|   |_____|     |.  _   | |   __| |   __|
           |:  |   |  V   i   s   t   r   o    A   p   p    |:  |   | |__|    |__|   
            \:.. ./                                         |::.|:. |                
             `---'                                          `--- ---'                
                                                                           

                                    f i r e b u g 5 0 9                     
*/

pragma solidity >=0.7.0 <0.9.0;

contract VistroApp is ERC721, Ownable, ReentrancyGuard, RandomlyAssigned  {
  using Strings for uint256;

  //collection details
  string public _collectionName= "Vistro App";
  string public _collectionSymbol="VISTRO";

  //metadata details
  string baseURI="ipfs://CID/";
  string public baseExtension = ".json";

  //mint details
  uint256 public cost = .5 ether;
  uint256 public whiteListCost = .5 ether;
  uint256 public maxSupply = 13000;
  uint256 public maxMintAmount = 5;
  uint256 public whiteListMintAmount=5;
  string public notRevealedUri;

  //track mints
  uint256 public startingMint=1;
  uint256 public amountMinted=0;
  uint256 public WLaddressCount;
  uint256 public WLClaimed;
  uint256 public RemainingclaimAddresses;
  uint256 public claimCount;

  //manage states
  //public sale toggle
  bool public publicActive = false;
  //white list toggle
  bool public whiteListActive=false;
  //claim list toggle
  bool public claimListActive=false;
  //reveal toggle
  bool public revealed = false;
  //collection lock
  bool public collectionLock=false;

  //cap amounts
  uint256 public capCount=2600;
  //cap stops
  bool public capHit = false; 


    //payable adresses on withdraw
    //address one = community wallet
    address private addressOne = 0x82939AE9f2D953357a0674DBBc6185Ee1032AA2A;
    address private addressTwo = 0x11b0D6947857f3F15377b3bfcE0F71fFD712edaD;
    address private addressThree = 0x50B3D4de2F3cc2aA44EA328Df4B5220c10DD87AA;
    address private addressFour = 0x3798B2C79FB4951834915ec569Ab7506f0d3e7c4;
    address private addressFive = 0x438FC0eaa85a60Aa3A4Ec49F77718B82547C657a;

    //whitelist mapping
    mapping(address => uint256) private _whiteList;
    //claim list mapping
    mapping(address => uint256) private _claimList;


  constructor() ERC721(_collectionName, _collectionSymbol) RandomlyAssigned(maxSupply,startingMint)
   {
    setNotRevealedURI("ipfs://QmRCwZXzMzWXc3ta6a4B8x2NtPmex5YxwBtnV4PK9KiFYX/HiddenMetadata.json");
    
 
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // public minting fuction
  function mint(uint256 _mintAmount) public payable {

    uint256 mintSupply = totalSupply();

if(capHit==false && (mintSupply+_mintAmount) >= capCount){
        publicActive=false;
        capHit=true;
    }
//manage public mint
    require(publicActive, "Contract is paused");
    require(_mintAmount > 0, "mint amount cant be 0");
    require(_mintAmount <= maxMintAmount, "Cant mint over the max mint amount");
    require(mintSupply + _mintAmount <= maxSupply, "Mint amount is too high there may not be enough left to mint that many");

    if (msg.sender != owner()) {
      require(msg.value >= cost * _mintAmount);
    }
   
    for (uint256 i = 1; i <= _mintAmount; i++) {
      uint256 randomNumber= nextToken();
      _safeMint(msg.sender, randomNumber);
    }
    amountMinted+=_mintAmount;
  }
  
function mintWhiteList(uint256 _mintAmount) public payable{

      uint256 mintSupply = totalSupply();

      if(capHit==false && (mintSupply+_mintAmount) >= capCount){
        whiteListActive=false;
        capHit=true;
    }
//manage whitelist request
    require(_whiteList[msg.sender]>0);
    require(whiteListActive, "whitelist not active");
    require(_mintAmount<=_whiteList[msg.sender],"Exceeded max available to purchase");
    require(_mintAmount > 0, "mint amount cant be 0");
    require(_mintAmount <= whiteListMintAmount, "Cant mint over the max mint amount");
    require(mintSupply + _mintAmount <= maxSupply, "Purchase would exceed max supply");
    require(msg.value>= whiteListCost*_mintAmount,"Eth value sent is not correct");

     _whiteList[msg.sender] -= _mintAmount;
        for (uint256 i = 1; i <= _mintAmount; i++) {
            uint256 randomNumber= nextToken();
    _safeMint(msg.sender, randomNumber);
      
      }
     if(_whiteList[msg.sender]==0){
          WLaddressCount-=1;
         
      }
    amountMinted+=_mintAmount;
    WLClaimed+=_mintAmount;
}

  //claimable list mint funtion
function mintClaimList(uint256 numberOfTokens) external payable {
    uint256 currentSupply = totalSupply();

    require(claimListActive, "Claim list is not active");
    require(numberOfTokens <= _claimList[msg.sender], "Exceeded max available to purchase");
    require(currentSupply + numberOfTokens <= maxSupply, "Purchase would exceed max supply");
    // cost taken down to 0 for claims
    //require(cost * numberOfTokens <= msg.value, "Eth value sent is not correct");

    _claimList[msg.sender] -= numberOfTokens;
    for (uint256 i = 1; i <= (numberOfTokens); i++) {
              uint256 randomNumber= nextToken();
        _safeMint(msg.sender, randomNumber);
    }
    if(_claimList[msg.sender]==0){
          RemainingclaimAddresses-=1;
       
      }
    amountMinted+=numberOfTokens;
    claimCount+=numberOfTokens;
 }

//return total supply minted
 function totalSupply() public view returns (uint256) {
    return amountMinted;
  }

//gas efficient function to find token ids owned by address
   function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory ownedTokenIds = new uint256[](ownerTokenCount);
    uint256 currentTokenId = 1;
    uint256 ownedTokenIndex = 0;

    while (ownedTokenIndex < ownerTokenCount && currentTokenId <= maxSupply) {
      address currentTokenOwner = ownerOf(currentTokenId);

      if (currentTokenOwner == _owner) {
        ownedTokenIds[ownedTokenIndex] = currentTokenId;
        ownedTokenIndex++;
      }
      currentTokenId++;
    }
    return ownedTokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(_exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
    
    if(revealed == false) {
        return notRevealedUri;
    }
    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

  //Access Functions
  //actions for the owner to interact with contract
  function setReveal(bool _newBool) public onlyOwner() {
      revealed = _newBool;
  }
// update mint cost
  function setCost(uint256 _newCost) public onlyOwner() {
    cost = _newCost;
  }
  // update WL mint cost
  function setWhiteListCost(uint256 _newCost) public onlyOwner() {
    whiteListCost = _newCost;
  }
// max mint amount
  function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner() {
    maxMintAmount = _newmaxMintAmount;
  }
// max WL amount
  function setMaxWlAmount(uint256 _newMaxWlAmount) public onlyOwner() {
    whiteListMintAmount= _newMaxWlAmount;
  }
//revealed bool  
  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }
//base URI extension
  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }
//set extension (.json)
  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }
//contract paused state
  function pause(bool _state) public onlyOwner {
    publicActive = _state;
  }

  //white list fuctions
  //set single address
  function setwhiteList(address addressInput, uint256 numAllowedToMint) external onlyOwner {
       
            _whiteList[addressInput] = numAllowedToMint;
            WLaddressCount+=1;
    }
  //set white list to true or false for active
    function setwhiteListActive(bool _whiteListActive) external onlyOwner {
        whiteListActive = _whiteListActive;
    }
  //set a full address list 
  function setFullwhiteList(address[] calldata addresses, uint256 numAllowedToMint) external onlyOwner {
    for (uint256 i = 0; i < addresses.length; i++) {
        _whiteList[addresses[i]] = numAllowedToMint;
    
    }
    WLaddressCount+=addresses.length;
 }

//claim functions
//set single claim address
  function setClaimList(address addressInput, uint256 numAllowedToMint) external onlyOwner {
       
            _claimList[addressInput] = numAllowedToMint;
            RemainingclaimAddresses+=1;
    }
//set claim list to true or false for active status
    function setClaimListActive(bool _claimListActive) external onlyOwner {
        claimListActive = _claimListActive;
    }
//set a full claim address list 
  function setFullClaimList(address[] calldata addresses, uint256 numAllowedToMint) external onlyOwner {
    for (uint256 i = 0; i < addresses.length; i++) {
        _claimList[addresses[i]] = numAllowedToMint;
    }
    RemainingclaimAddresses+=addresses.length;
 }

//adjust claimable cut off point
  function setClaimableCap(uint256 _newCap) public onlyOwner() {
    capCount=_newCap;
  }
//ability to change capHit back to false
  function setCapBool(bool _newCap) public onlyOwner() {
    capHit=_newCap;
  }

// Lock for collection amount once locked CAUTION: cannot be unlocked
  function CollectionsizeLock() public onlyOwner{
    collectionLock = true;
  }
//collection size change
  function collectionSizeChange(uint256 change) public onlyOwner{
    require(collectionLock==false, "collection size cannot be changed anymore");
    maxSupply = change;
  }

 //primary withdraw, withdraw % to address 1 % to address 2
  function primaryWithdraw() public payable onlyOwner nonReentrant{
   uint256 CurrentBalance = address(this).balance;
        payable(addressOne).transfer((CurrentBalance * 20) / 100);
        payable(addressTwo).transfer((CurrentBalance * 20) / 100);
        payable(addressThree).transfer((CurrentBalance * 20) / 100);
        payable(addressFour).transfer((CurrentBalance * 20) / 100);
        payable(addressFive).transfer((CurrentBalance * 20) / 100);

   }
//backup witdraw to retrieve all funds to deployment account 
  function backupWithdraw() public payable onlyOwner nonReentrant{
 
    (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(success);
  }
}
