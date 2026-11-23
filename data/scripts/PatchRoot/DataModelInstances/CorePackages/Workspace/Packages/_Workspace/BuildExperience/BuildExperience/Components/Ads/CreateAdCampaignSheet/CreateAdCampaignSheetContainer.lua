-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local React = require(BuildExperienceParent.React)

local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local CreateAdCampaignSheetView = require(script.Parent.CreateAdCampaignSheetView)
local useCreateAdCampaignSheetViewModel = require(script.Parent.useCreateAdCampaignSheetViewModel)

local function getCampaignTerms(arg1): {runStartTimeMs: any}? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1.runStartTimeMs == nil then nil else {
        runStartTimeMs = arg1.runStartTimeMs
    }
end

local function MountedCreateAdCampaignSheet(arg1)
    local var1 = useCreateAdCampaignSheetViewModel(arg1)
    return React.createElement(CreateAdCampaignSheetView, var1)
end

local function CreateAdCampaignSheetContainer(arg1)
    local var1, var2 = React.useState(arg1.isOpen)

    local isOpen = FFlagEnablePaidAds and arg1.isOpen
    local var3, var4 = React.useState({ wasOpen = isOpen, terms = if isOpen then getCampaignTerms(arg1) else nil })

    local bool1 = var3.wasOpen ~= isOpen
    local bool2

    if FFlagBuildAgentAdCampaignCard and isOpen and arg1.runStartTimeMs ~= nil then
        local terms = var3.terms
        bool2 = terms == nil or terms.runStartTimeMs ~= arg1.runStartTimeMs
    else
        bool2 = false
    end

    local tbl1

    if bool1 or FFlagBuildAgentAdCampaignCard and bool2 then
        tbl1 = {
            wasOpen = isOpen,
            terms = if isOpen then getCampaignTerms(arg1) else var3.terms
        }
        var4(tbl1)
    else
        tbl1 = var3
    end

    React.useEffect(function()
        if arg1.isOpen then
            var2(true)
        end
    end, { arg1.isOpen })

    if not var1 or FFlagEnablePaidAds and arg1.campaignOffers == nil then
        return nil
    end

    local var5

    if FFlagEnablePaidAds then
        local terms = tbl1.terms
        if terms == nil then
            return nil
        end
        var5 = table.clone(arg1)
        var5.runStartTimeMs = terms.runStartTimeMs
    else
        var5 = arg1
    end

    return React.createElement(MountedCreateAdCampaignSheet, var5)
end

return CreateAdCampaignSheetContainer
