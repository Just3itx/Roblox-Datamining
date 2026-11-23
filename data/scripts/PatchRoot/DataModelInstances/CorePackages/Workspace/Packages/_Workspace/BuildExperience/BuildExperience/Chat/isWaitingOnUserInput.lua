-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local BuildExperienceParent = BuildExperience.Parent
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local SharedFlags = require(BuildExperienceParent.SharedFlags)

local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildExperienceManageGamePass = SharedFlags.FFlagBuildExperienceManageGamePass
local FFlagBuildExperienceManageSubscription = SharedFlags.FFlagBuildExperienceManageSubscription

local unifiedMonetizationTool = require(script.Parent.unifiedMonetizationTool)

local StudioAskUserTool = CreatorAgentChat.StudioAskUserTool
local StudioManageDevProductTool = CreatorAgentChat.StudioManageDevProductTool
local StudioManageGamePassTool = CreatorAgentChat.StudioManageGamePassTool
local StudioManageSubscriptionTool = CreatorAgentChat.StudioManageSubscriptionTool
local StudioProposePlanTool = CreatorAgentChat.StudioProposePlanTool

local function isWaitingOnMonetizationApproval(arg1, tbl1, func1: (...any) -> (...any), func2: (...any) -> (...any), getActionKind: (...any) -> (...any))
    local var1 = table.clone(tbl1)
    while true do
        local var2, var3 = func1(arg1, var1)
        if var2 == nil then
            break
        end

        local var4 = func2(var3)
        if var4 ~= nil and getActionKind(var4.action) == "mutation" then
            return true
        end

        var1[var2] = true
    end

    return false
end

local function isWaitingOnDevProductApproval(arg1, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isWaitingOnMonetizationApproval(
        arg1,
        tbl1,
        StudioManageDevProductTool.findManageDevProductRequestInTurnState,
        StudioManageDevProductTool.parseManageDevProductInput,
        StudioManageDevProductTool.getActionKind
    )
end

local function isWaitingOnGamePassApproval(arg1, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isWaitingOnMonetizationApproval(
        arg1,
        tbl1,
        StudioManageGamePassTool.findRequestInTurnState,
        StudioManageGamePassTool.parseInput,
        StudioManageGamePassTool.getActionKind
    )
end

local function isWaitingOnSubscriptionApproval(arg1, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isWaitingOnMonetizationApproval(
        arg1,
        tbl1,
        StudioManageSubscriptionTool.findRequestInTurnState,
        StudioManageSubscriptionTool.parseInput,
        StudioManageSubscriptionTool.getActionKind
    )
end

local function isWaitingOnUnifiedApproval(arg1, tbl1)
    for _, value in unifiedMonetizationTool.toolsByKind do
        if isWaitingOnMonetizationApproval(arg1, tbl1, value.findRequestInTurnState, value.parseInput, value.getActionKind) then
            return true
        end
    end
    return false
end

local function isWaitingOnUserInput(arg1, tbl1)
    local _, var1 = StudioAskUserTool.findQuestionsInTurnState(arg1, tbl1)
    if var1 ~= nil then
        return true
    end

    local _, var2 = StudioProposePlanTool.findPlanInTurnState(arg1, tbl1)
    if var2 ~= nil then
        return true
    elseif unifiedMonetizationTool.isEnabled then
        return (isWaitingOnUnifiedApproval(arg1, tbl1))
    end

    return if FFlagBuildExperienceManageDevProduct and isWaitingOnDevProductApproval(arg1, tbl1) then true elseif FFlagBuildExperienceManageGamePass and FFlagBuildExperienceManageDevProduct and isWaitingOnGamePassApproval(arg1, tbl1) then true else FFlagBuildExperienceManageSubscription
        and FFlagBuildExperienceManageDevProduct
        and isWaitingOnSubscriptionApproval(arg1, tbl1)
end

return isWaitingOnUserInput
