// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.12;

import "@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol";

/// @dev Stripped-down essentials of a UniswapV3Pool for oracle tests
/// @dev copied from https://github.com/sohkai/uniswap-v3-spot-twap-oracle/blob/main/contracts/test/MockUniswapV3Pool.sol
contract MockUniswapV3Pool {
    address public immutable token0;
    address public immutable token1;

    // Stripped-down slot0
    struct Slot0 {
        int24 tick;
        uint16 observationIndex;
        uint16 observationCardinality;
    }

    Slot0 public slot0;

    struct Observation {
        uint32 blockTimestamp;
        int56 tickCumulative;
        bool initialized;
    }

    Observation[] public observations;

    constructor(address _tokenA, address _tokenB, uint16 _observationCardinality) {
        PoolAddress.PoolKey memory poolKey = PoolAddress.getPoolKey(
            _tokenA,
            _tokenB,
            uint24(0) // pool fee is unused
        );

        token0 = poolKey.token0;
        token1 = poolKey.token1;

        slot0.observationCardinality = _observationCardinality;
        for (; _observationCardinality > 0; --_observationCardinality) {
            observations.push();
        }
    }

    /**
     *
     * Mocking management *
     *
     */
    function setObservations(uint32[] calldata _blockTimestamps, int56[] calldata _tickCumulatives) external {
        require(
            _blockTimestamps.length == _tickCumulatives.length,
            "MockUniswapV3Pool#setObservations called with invalid array lengths (must be matching)"
        );
        require(
            _blockTimestamps.length <= slot0.observationCardinality,
            "MockUniswapV3Pool#setObservations called with invalid array lengths (must be < slot0.observationCardinality)"
        );

        for (uint256 ii; ii < _blockTimestamps.length; ++ii) {
            observations[ii] = Observation(_blockTimestamps[ii], _tickCumulatives[ii], true);
        }
    }

    function setSlot0(int24 _tick, uint16 _observationIndex) external {
        require(
            _observationIndex < slot0.observationCardinality,
            "MockUniswapV3Pool#setSlot0 called with invalid observationIndex (must be < slot0.observationCardinality)"
        );

        slot0.tick = _tick;
        slot0.observationIndex = _observationIndex;
    }
}
