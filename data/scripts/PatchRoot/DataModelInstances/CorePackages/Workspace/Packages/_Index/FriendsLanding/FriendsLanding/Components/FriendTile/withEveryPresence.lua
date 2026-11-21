-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Parent = require(script.Parent)
local Roact = dependencies.Roact
local llama = dependencies.llama

local friendsWithPresence = require(script.Parent.friendsWithPresence)

return function(arg1)
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        frame = Roact.createElement("Frame", {
            Size = UDim2.new(0, 150, 0, 0),
            BackgroundTransparency = 1
        }, {
            layout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 6)
                }
            ),
            OnlineFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.OnlineFriend })),
            DeletedFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.DeletedFriend })),
            OfflineFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.OfflineFriend })),
            InGameFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.InGameFriend })),
            InGameWithoutLastLocationFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.InGameWithoutLastLocationFriend })),
            InStudioFriend = Roact.createElement(Parent, llama.Dictionary.join(arg1, { user = friendsWithPresence.InStudioFriend })),
            InStudioWithoutLastLocationFriend = Roact.createElement(
                Parent,
                llama.Dictionary.join(arg1, { user = friendsWithPresence.InStudioWithoutLastLocationFriend })
            )
        })
    })
end
