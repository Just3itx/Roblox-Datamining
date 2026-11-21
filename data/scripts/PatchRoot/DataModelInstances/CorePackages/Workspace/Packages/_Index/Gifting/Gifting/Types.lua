-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local _HttpClient = require(GiftingParent.HttpClient)

local _Constants = require(Gifting.Constants)
local _ItemType = require(Gifting.Enums.ItemType)
local _GiftEligibility = require(Gifting.Enums.GiftEligibility)
local _RequiredAction = require(Gifting.Enums.RequiredAction)
local _UserRelationship = require(Gifting.Enums.UserRelationship)
local _FailureReason = require(Gifting.Enums.FailureReason)
local _AmpRecourseAction = require(Gifting.Enums.AmpRecourseAction)

return {}
