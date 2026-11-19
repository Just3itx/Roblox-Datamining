-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local PageNavigationWatcher = require(scriptParentParent.Components.PageNavigationWatcher)
local Page = require(scriptParentParent.Components.Page)
local ReportList = require(script.ReportList)

local function getReportablePlayers()
    local reportablePlayers = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(reportablePlayers, player)
        end
    end

    return reportablePlayers
end

local var1 = Roact.PureComponent:extend("ReportPage")
var1.validateProps = t.strictInterface({ pageTitle = t.string })

function var1.init(arg1)
    arg1:setState({ players = getReportablePlayers() })
end

function var1.render(arg1)
    return Roact.createElement(Page, {
        pageTitle = arg1.props.pageTitle
    }, {
        PlayerList = Roact.createElement(ReportList, { players = arg1.state.players }),
        Watcher = Roact.createElement(PageNavigationWatcher, {
            desiredPage = "Report",
            onNavigateTo = function()
                arg1:setState({ players = getReportablePlayers() })
            end
        })
    })
end

return var1
