-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local Foundation = require(ProgressLoadingParent.Foundation)
local Localization = require(ProgressLoadingParent.Localization)
local InExperienceLocales = require(ProgressLoadingParent.InExperienceLocales)

local LocalizationService = game:GetService("LocalizationService")

return {
    makeAnimationBindings = function()
        return {
            keyart = {
                rotation = React.createBinding(15),
                sizeScale = React.createBinding(1),
                coverTransparency = React.createBinding(1)
            },
            frame = {
                rotation = React.createBinding(-15),
                sizeScale = React.createBinding(1),
                groupTransparency = React.createBinding(0)
            },
            title = {
                reveal = React.createBinding(1),
                slide = React.createBinding(UDim.new(0, 0))
            },
            creator = {
                reveal = React.createBinding(1),
                slide = React.createBinding(UDim.new(0, 0))
            },
            verified = {
                reveal = React.createBinding(1)
            }
        }
    end,
    makeStatusPanelProps = function(arg1)
        local tbl1 = {
            status = "",
            statusText = "",
            queuePosition = nil,
            queueTreatment = nil,
            followUserId = 0,
            isSubjectToChinaPolicies = false,
            onAutoJoinNewServer = function() end,
            onJoinNewServer = function() end,
            onJoinTheLine = function() end,
            onShowConnectionHealth = function() end
        }
        if arg1 then
            for value, value2 in arg1 do
                tbl1[value] = value2
            end
        end
        return tbl1
    end,
    renderWithFoundation = function(func1: (...any) -> (...any), subject)
        return func1(
            React.createElement(Foundation.FoundationProvider, {
                colorMode = Foundation.Enums.ColorMode.Dark
            }, {
                Localization = React.createElement(
                    Localization.LocalizationProvider,
                    {
                        localization = InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
                    },
                    { Subject = subject }
                )
            })
        )
    end
}
