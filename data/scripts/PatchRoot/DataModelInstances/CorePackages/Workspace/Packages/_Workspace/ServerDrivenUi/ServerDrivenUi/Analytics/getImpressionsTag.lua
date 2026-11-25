-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local _UnifiedLogging = require(ServerDrivenUiParent.UnifiedLogging)
local SduiErrors = require(ServerDrivenUiParent.SduiCoreSystem).SduiErrors

local function getImpressionsTag(num1: number, arg1, arg2, name: string?): string
    local collectionId = nil
    local collectionComponentType = nil
    if arg1 then
        collectionId = arg1.collectionId
        collectionComponentType = arg1.collectionComponentType
        if not collectionComponentType then
            arg2.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionComponentType,
                { name = name },
                arg2.appPage
            )
        end
        if not collectionId then
            arg2.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionId,
                { name = name },
                arg2.appPage
            )
        end
    else
        arg2.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.GetImpressionsTagMissingCollectionData,
            { name = name },
            arg2.appPage
        )
    end
    return `{name}_{collectionComponentType}_{arg2.routeName or arg2.appPage}_{collectionId or -1}_{num1}`
end

return getImpressionsTag
