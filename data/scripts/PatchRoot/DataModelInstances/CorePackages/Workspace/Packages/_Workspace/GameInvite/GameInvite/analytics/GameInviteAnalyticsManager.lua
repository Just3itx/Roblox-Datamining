-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteAnalytics = require(GameInvite.analytics.GameInviteAnalytics)
local GameInviteParent = GameInvite.Parent

local EventStream = require(GameInviteParent.Analytics).AnalyticsReporters.EventStream
local Diag = require(GameInviteParent.Analytics).AnalyticsReporters.Diag

return (GameInviteAnalytics.new():withEventStream(EventStream.new(RbxAnalyticsService)):withDiag(Diag.new(RbxAnalyticsService)))
