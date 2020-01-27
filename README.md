# ICOFactory consists of:
- Token
- Crowdsale
- Fund Manager
- ICO Launcher

## Token specification:
- configurable to select features:
  - Mintable
  - Burnable
  - Capped/uncapped
  - Pausable
  
## Crowdsale specification:
- Purchasable by Ether, and Stable coins
- Fully configurable to set:
  - softcap
  - hardcap
  - General Min/Max of individual invest
  - Crowdsale Rounds:
    - Multiple Round configuration
    - Start/End of each Round
    - Min/Max of individual invest
    - Total Cap of each Round
    - token price
- Investors' whitelist
- Refundable
- Withdrawal Management
- Finalization Management (connected to Fund Manager contract)

## Fund Manager
- Fund management by voting
- Configurable Voting (Winning  criteria)
- Two main voting types:
  - Fund Raising Voting (req by Project manager)
  - Project Termination Voting (req by Oracles)
- Oracle Whitelist

## Launcher
- Automated Launcher of a full STO project on demand configurations:
  - Token Configurations:
    - Name
    - Symbol
    - Decimals
    - Pausable
    - Capped/uncapped
    - Token Cap

  - Crowdsale configurations:
    - softcap
    - hardcap
    - General Min/Max of individual invest

  - Fund Manager configurations:
    - Min votes to win voting