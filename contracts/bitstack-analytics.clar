;; Title: 
;; Bitstack: Decentralized Data Governance & Staking Protocol

;; Summary
;; Bitstack is a Stacks L2-powered platform combining decentralized analytics, governance, and staking mechanics.
;; Users stake STX to participate in data governance, earn yield, and shape the platform's evolution through proposals.

;; Description
;; Bitstack redefines decentralized analytics by creating a stakeholder-driven ecosystem on Bitcoin L2.
;; The protocol features:
;; - Tiered STX staking with time-lock boosted rewards
;; - On-chain governance with proposal lifecycle management
;; - INSIGHT utility token for voting rights and platform access
;; - Adaptive reward mechanisms aligned with network participation
;; - Emergency safeties and multi-tier user privileges

;; Designed for DeFi analysts and data DAOs, Bitstack creates a circular economy where data consumers become
;; network stakeholders. The contract implements sophisticated reward calculus with block-based vesting schedules
;; and anti-sybil voting weights.

;; token definitions
(define-fungible-token ANALYTICS-TOKEN u0)

;; constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u1000))
(define-constant ERR-INVALID-PROTOCOL (err u1001))
(define-constant ERR-INVALID-AMOUNT (err u1002))
(define-constant ERR-INSUFFICIENT-STX (err u1003))
(define-constant ERR-COOLDOWN-ACTIVE (err u1004))
(define-constant ERR-NO-STAKE (err u1005))
(define-constant ERR-BELOW-MINIMUM (err u1006))
(define-constant ERR-PAUSED (err u1007))

;; data vars
(define-data-var contract-paused bool false)
(define-data-var emergency-mode bool false)
(define-data-var stx-pool uint u0)
(define-data-var base-reward-rate uint u500) ;; 5% base rate (100 = 1%)
(define-data-var bonus-rate uint u100) ;; 1% bonus for longer staking
(define-data-var minimum-stake uint u1000000) ;; Minimum stake amount
(define-data-var cooldown-period uint u1440) ;; 24 hour cooldown in blocks
(define-data-var proposal-count uint u0)

;; data maps
(define-map Proposals
    { proposal-id: uint }
    {
        creator: principal,
        description: (string-utf8 256),
        start-block: uint,
        end-block: uint,
        executed: bool,
        votes-for: uint,
        votes-against: uint,
        minimum-votes: uint
    }
)

(define-map UserPositions
    principal
    {
        total-collateral: uint,
        total-debt: uint,
        health-factor: uint,
        last-updated: uint,
        stx-staked: uint,
        analytics-tokens: uint,
        voting-power: uint,
        tier-level: uint,
        rewards-multiplier: uint
    }
)