-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local AppComposition = require(BuildExperienceParent.AppComposition)
local Display = require(BuildExperienceParent.Display)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local LibraryTile = require(script.Parent.Parent.LibraryTile)
local _LibraryTypes = require(script.Parent.Parent.LibraryTypes)
local LibraryWorldCutoutView = require(script.Parent.Parent.LibraryWorldCutout.LibraryWorldCutoutView)
local useHardwareInsets = require(BuildExperience.Components.ChatSheet.useHardwareInsets)

local Icon = Foundation.Icon
local ScrollView = Foundation.ScrollView
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local function renderLoadingTiles(str1: string, offset: number, num1: number, arg1)
    local tbl1 = ({})
    for layoutOrder = 1, 4 do
        local str2 = tostring(layoutOrder)
        local createElement = React.createElement
        local var1 = View
        local tbl2 = {
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(num1, num1 + arg1.Size.Size_1000),
            tag = "col gap-small",
            testId = `Library.Category.{str1}.Skeleton.{layoutOrder}`
        }
        local tbl3 = {
            Thumbnail = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(num1, num1), radius = Radius.Medium }),
            Title = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 2,
                    Size = UDim2.fromOffset(arg1.Size.Size_1800, arg1.Size.Size_400),
                    radius = Radius.Small
                }
            )
        }
        tbl1[str2] = createElement(var1, tbl2, tbl3)
    end

    return React.createElement(ScrollView, {
        Size = UDim2.new(1, 0, 0, num1 + arg1.Size.Size_1000),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.X,
            scrollBarVisibility = ScrollBarVisibility.None
        },
        testId = `Library.Category.{str1}.Skeleton`
    }, {
        Content = React.createElement(
            View,
            {
                padding = {
                    left = UDim.new(0, offset),
                    right = UDim.new(0, offset)
                },
                tag = "row gap-small size-0-full auto-x"
            },
            tbl1
        )
    })
end

local function renderCategory(arg1, layoutOrder: number, offset: number, num1: number, arg2)
    local yOffset = num1 + arg2.Size.Size_1000
    local tbl1 = ({})
    local var1 = arg1.categoryKey or arg1.itemKind
    for k, item in arg1.items do
        local var2 = item.tileKey or item.itemId or tostring(k)
        tbl1[var2] = React.createElement(LibraryTile, {
            compact = true,
            tileKey = item.tileKey,
            itemId = item.itemId,
            itemKind = item.itemKind,
            isFolder = item.isFolder,
            folderPreview = item.folderPreview,
            displayName = item.displayName,
            unavailableText = item.unavailableText,
            thumbnail = item.thumbnail,
            model = item.model,
            onActivated = item.onActivated,
            LayoutOrder = k,
            Size = UDim2.fromOffset(num1, yOffset),
            mediaSize = UDim2.fromOffset(num1, num1)
        })
    end

    local onOpenCategory = if arg1.status == "Ready" then arg1.onOpenCategory else nil
    local element

    if arg1.status == "Loading" or arg1.status == "NotReady" then
        element = renderLoadingTiles(var1, offset, num1, arg2)
    else
        element = React.createElement(ScrollView, {
            onCanvasPositionChanged = arg1.onScrollChanged,
            onAbsoluteCanvasSizeChanged = arg1.onScrollChanged,
            onAbsoluteWindowSizeChanged = arg1.onScrollChanged,
            Size = UDim2.new(1, 0, 0, yOffset),
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromOffset(0, 0),
                ScrollingDirection = Enum.ScrollingDirection.X,
                scrollBarVisibility = ScrollBarVisibility.None
            },
            testId = `Library.Section.{var1}.Carousel`
        }, {
            Content = React.createElement(
                View,
                {
                    padding = {
                        left = UDim.new(0, offset),
                        right = UDim.new(0, offset)
                    },
                    tag = "row gap-small size-0-full auto-x"
                },
                tbl1
            )
        })
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = layoutOrder,
        tag = "col gap-large size-full-0 auto-y",
        testId = `Library.Category.{var1}`
    }
    local tbl3 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            onActivated = onOpenCategory,
            selection = {
                Selectable = onOpenCategory ~= nil
            },
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            padding = {
                left = UDim.new(0, offset),
                right = UDim.new(0, offset)
            },
            tag = "row align-y-center gap-xsmall size-full-600",
            testId = `Library.Category.{var1}.Header`
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.title,
                tag = "auto-xy text-heading-small text-align-x-left content-emphasis",
                testId = `Library.Section.{var1}.Title`
            }),
            Chevron = if onOpenCategory == nil then nil else React.createElement(Icon, {
                LayoutOrder = 2,
                name = IconName.ChevronLargeRight,
                size = IconSize.Small,
                style = arg2.Color.Content.Default,
                testId = `Library.Category.{var1}.Header.Chevron`
            })
        }),
        Cells = React.createElement(
            View,
            {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, yOffset),
                testId = `Library.Category.{var1}.Cells`
            },
            { Content = element }
        )
    }
    return createElement(var2, tbl2, tbl3)
end

local function LibraryBrowserView(tbl1)
    local margin = AppComposition.useCompositionLayout().margin
    local bottom = useHardwareInsets().bottom
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Foundation.Hooks.useScaledValue(160)
    if SignalsReact.useSignalState(Display.GetDisplayStore(false).getDisplaySize) == Enum.DisplaySize.Small then
        var2 = var1.Size.Size_2400
    end

    local tbl2 = {}
    for value, value2 in tbl1.categories do
        tbl2[value2.categoryKey or value2.itemKind] = renderCategory(value2, value, margin, var2, var1)
    end

    if tbl1.status == "Loading" or tbl1.status == "NotReady" then
        tbl2 = {}
        for layoutOrder, value2 in { "Model", "Image", "Sound" } do
            local createElement = React.createElement
            local var3 = View
            local tbl3 = {
                LayoutOrder = layoutOrder,
                tag = "col gap-large size-full-0 auto-y",
                testId = `Library.Section.{value2}.Skeleton`
            }
            local tbl4 = { Heading = 0, Cards = 0 }
            local createElement2 = React.createElement
            local var4 = View
            local tbl5 = {
                LayoutOrder = 1,
                padding = {
                    left = UDim.new(0, margin),
                    right = UDim.new(0, margin)
                },
                tag = "size-full-0 auto-y"
            }
            local tbl6 = {
                Skeleton = React.createElement(Skeleton, {
                    Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_600),
                    radius = Radius.Small,
                    testId = `Library.Section.{value2}.HeadingSkeleton`
                })
            }
            tbl4.Heading = createElement2(var4, tbl5, tbl6)

            tbl4.Cards = React.createElement(
                View,
                { LayoutOrder = 2, tag = "size-full-0 auto-y" },
                {
                    Content = renderLoadingTiles(value2, margin, var2, var1)
                }
            )
            tbl2[value2] = createElement(var3, tbl3, tbl4)
        end
    elseif #tbl1.categories == 0 then
        tbl2.Empty = React.createElement(FoundationText, {
            Text = tbl1.strings.empty,
            tag = "size-full-0 auto-y padding-large text-body-medium text-align-x-center content-muted"
        })
    end

    local worldCutout = tbl1.worldCutout
    if worldCutout ~= nil then
        tbl2.WorldCutout = React.createElement(LibraryWorldCutoutView, {
            LayoutOrder = 0,
            inset = margin,
            isLoading = tbl1.status == "Loading" or tbl1.status == "NotReady",
            title = worldCutout.title,
            onActivated = worldCutout.onActivated,
            onRectChanged = worldCutout.onRectChanged
        })
    end

    local content = React.createElement(
        View,
        {
            padding = {
                bottom = UDim.new(0, var1.Padding.Small + bottom)
            },
            tag = "col size-full-0 auto-y padding-top-medium",
            testId = "Library.Browser.Content"
        },
        {
            Categories = React.createElement(View, { LayoutOrder = 1, tag = "col gap-large size-full-0 auto-y" }, tbl2)
        }
    )

    return React.createElement(View, { tag = "col size-full", testId = "Library.Browser" }, {
        Body = React.createElement(ScrollView, {
            LayoutOrder = 1,
            tag = "fill size-full-0",
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.fromOffset(0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            }
        }, { Content = content })
    })
end

return LibraryBrowserView
