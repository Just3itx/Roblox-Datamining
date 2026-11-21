-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local ContactImporterParent = ContactImporter.Parent
local dependencies = require(ContactImporter.dependencies)

local useAppPolicy = require(ContactImporterParent.UniversalAppPolicy).useAppPolicy
local useDispatch = require(ContactImporterParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Roact = dependencies.Roact
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local useLocalization = dependencies.useLocalization
local useStyle = dependencies.useStyle

local FullPageModal = UIBlox.App.Dialog.Modal.FullPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local SectionList = dependencies.SectionList

local TextKeys = require(ContactImporter.Common.TextKeys)
local ContactsListEntry = require(ContactImporter.ContactsList.Components.ContactsListEntry)
local ContactsListInviteEntry = require(ContactImporter.ContactsList.Components.ContactsListInviteEntry)
local ContactsEmptyList = require(ContactImporter.ContactsList.Components.ContactsEmptyList)
local ContactsUploadErrorModal = require(ContactImporter.ContactsList.Components.ContactsUploadErrorModal)
local ContactsGlimmer = require(ContactImporter.ContactsList.Components.ContactsGlimmer)

local ContactsSyncWarningMessage = require(ContactImporter.ContactsList.Components.ContactsSyncWarningMessage)

local EventNames = require(ContactImporter.Analytics).EventNames
local _LocalTypes = require(ContactImporter.Common.LocalTypes)

local ContactsListSearchBar = require(ContactImporter.ContactsList.Components.ContactsListSearchBar)
local Dash = dependencies.Dash

local Foundation = require(ContactImporterParent.Foundation)
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize

local AppPage = require(ContactImporterParent.RobloxAppEnums).AppPage
local NavigateDown = require(ContactImporterParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ContactImporterParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ContactImporterParent.RobloxAppNavigation).NavigationCommands else nil
local ContactImportButtonsIXP = require(ContactImporter.Flags.ContactImportButtonsIXP)

local bool1 = game:DefineFastFlag("ContactImportButtonsExperimentEnabled", false)

local IXPService = game:GetService("IXPService")
local uprankContactsWithEmoji = require(ContactImporter.Utils).uprankContactsWithEmoji
local FFlagContactsListEmojiSorting = require(ContactImporter.Flags.FFlagContactsListEmojiSorting)
local bool2 = game:DefineFastFlag("ContactsListEmojiSortingIxpEnabled", false)

local layerName = game:DefineFastString("ContactsListEmojiSortingIxpLayer", "Social.ContactListEmojiSorting")
local FFlagQRCodeCopyUpdates = require(ContactImporterParent.SharedFlags).FFlagQRCodeCopyUpdates
local FStringCanAccessTrustedContactsAmpFeature = require(ContactImporterParent.SharedFlags).FStringCanAccessTrustedContactsAmpFeature
local FStringIsUserInTcEligibleCountryAmpFeature = require(ContactImporterParent.SharedFlags).FStringIsUserInTcEligibleCountryAmpFeature
local FFlagTCPolicyCheckRedirect = require(ContactImporterParent.SharedFlags).FFlagTCPolicyCheckRedirect
local FStringCanAccessTrustedContactsAmpNameSpace = require(ContactImporterParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
local AmpApiProvider = require(ContactImporterParent.AmpUpsell).AmpApiProvider
local AmpEnums = require(ContactImporterParent.AmpUpsell).AmpEnums

local UserInputService = dependencies.UserInputService

local function ContactsList(tbl1)
    local var1 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var2 = useStyle()
    local var3 = useDispatch()

    local var4 = useLocalization({
        fromContactsText = TextKeys.ON_ROBLOX,
        inviteToRobloxText = TextKeys.INVITE_TO_ROBLOX,
        contactsListBlurb = TextKeys.CONTACTS_LIST_DESCRIPTION,
        contactsListTFEducationBlurb = TextKeys.ADD_CONTACTS_AS_TRUSTED_FRIENDS_DESCRIPTION,
        connectWithFriends = TextKeys.CONTACTS_LIST_TITLE,
        closeModal = TextKeys.CLOSE_MODAL,
        goToAddFriends = TextKeys.GO_TO_ADD_FRIENDS,
        searchContacts = TextKeys.SEARCH_CONTACTS,
        learnMore = "Feature.Chat.Action.LearnMore"
    })
    local var5 = if bool1 then ContactImportButtonsIXP.useIsRemoveCloseButtonExperimentEnabled({ isExposureEnabled = true }) else false

    local function func1(tbl2, arg1, arg2)
        local var6 = #arg1 ~= 0 and {{ isSectionDivider = true }} or nil
        Dash.append(tbl2, arg1, var6, arg2)
    end

    local function onActivated()
        tbl1.closeModal(EventNames.CloseContactListButton)
    end

    local function onCloseClicked()
        tbl1.closeModal(EventNames.CloseContactListCross)
    end

    local var6 = React.useCallback(function()
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = "https://en.help.roblox.com/hc/en-us/articles/37725513985812",
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var3(NavigateDown(tbl2, nil))
    end, { var3 })

    local var7, var8 = React.useState("")

    local function func4(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        return Dash.filter(arg1, function(arg2): boolean
            if arg2.contactName == nil then
                return string.find(string.lower(arg2.contactName or ""), string.lower(var7)) ~= nil
            end

            if arg2.contactName:match("^%s*$") then
                return false
            end

            return string.find(string.lower(arg2.contactName or ""), string.lower(var7)) ~= nil
        end)
    end

    local var9 = if FFlagContactsListEmojiSorting then React.useMemo(function()
        return uprankContactsWithEmoji(tbl1.matchedContacts)
    end, { tbl1.matchedContacts }) else nil

    local var10 = if FFlagContactsListEmojiSorting then React.useMemo(function()
        return uprankContactsWithEmoji(tbl1.deviceContacts)
    end, { tbl1.deviceContacts }) else nil

    local var11 = if FFlagContactsListEmojiSorting then func4(var9) else func4(tbl1.matchedContacts)
    local var12 = if FFlagContactsListEmojiSorting then func4(var10) else func4(tbl1.deviceContacts)

    if bool2 then
        React.useEffect(function()
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end, {})
    end

    local var13, var14 = React.useState(false)

    if FFlagQRCodeCopyUpdates then
        React.useEffect(function()
            local var15 = if FFlagTCPolicyCheckRedirect then FStringIsUserInTcEligibleCountryAmpFeature else FStringCanAccessTrustedContactsAmpFeature

            if AmpApiProvider.upsellFeatureAccess(var15, {}, FStringCanAccessTrustedContactsAmpNameSpace).access == AmpEnums.AccessResponseEnum.Granted then
                var14(true)
            end
        end)
    end

    local tbl2 = {}
    func1(tbl2, var11, var12)

    local sections = {}

    if #var11 > 0 then
        table.insert(sections, { data = var11, title = var4.fromContactsText, sectionNumber = #sections + 1 })
    end

    if #var12 > 0 then
        table.insert(sections, { data = var12, title = var4.inviteToRobloxText, sectionNumber = #sections + 1 })
    end

    local function func5(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        return #tbl1.matchedContacts + #tbl1.deviceContacts == 0
    end

    local function renderItem(arg1)
        local item = arg1.item
        if item.isSectionDivider then
            local _ = arg1.index ~= 1
            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl4 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 24)
            }
            local tbl5 = {
                divider = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = var2.Theme.Divider.Color,
                    BackgroundTransparency = var2.Theme.Divider.Transparency
                })
            }
            return createElement(str1, tbl4, tbl5)
        elseif item.isMatchedContact then
            return Roact.createElement(ContactsListEntry, {
                contactName = item.contactName,
                contactId = item.contactId,
                contextualInfo = var4.fromContactsText,
                hasDivider = true,
                hasSentRequest = item.hasSentRequest,
                requestFriendship = tbl1.requestFriendship,
                openProfilePeekView = tbl1.openProfilePeekView,
                headshotThumbnailUrl = item.headshotThumbnailUrl,
                avatarThumbnailUrl = item.avatarThumbnailUrl
            })
        else
            return Roact.createElement(ContactsListInviteEntry, {
                contactName = item.contactName,
                deviceContactId = item.deviceContactId,
                hasDivider = true,
                phoneNumber = item.phoneNumber,
                hasSentRequest = item.hasSentRequest
            })
        end
    end

    local function func7(arg1)
        if not arg1.section then
            return Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 24)
            }, {
                divider = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = var2.Theme.Divider.Color,
                    BackgroundTransparency = var2.Theme.Divider.Transparency
                })
            })
        end

        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0)
        }, {
            layout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            ),
            padding = if arg1.section.sectionNumber == 1 then nil else Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 1 }),
            Roact.createElement("Frame", {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1
            }, {
                sectionHeaderTextLabel = Roact.createElement(
                    StyledTextLabel,
                    {
                        fontStyle = var2.Font.Header2,
                        colorStyle = var2.Theme.TextDefault,
                        text = arg1.section.title or ""
                    }
                )
            })
        })
    end
    local function func8(arg1)
        if tbl1.isFetching then
            return {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    isLoading = true,
                    onActivated = Dash.noop
                }
            }}
        end

        if not (tbl1.showAddFriendsButton and func5()) then
            if var5 then
                return {}
            end

            return {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = onActivated,
                    text = arg1.closeModal
                }
            }}
        end

        if var5 then
            return {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = tbl1.onAddFriendsActivated,
                    text = arg1.goToAddFriends
                }
            }}
        end

        return {
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = tbl1.onAddFriendsActivated,
                    text = arg1.goToAddFriends
                }
            },
            {
                buttonType = ButtonType.Secondary,
                props = {
                    onActivated = onActivated,
                    text = arg1.closeModal
                }
            }
        }
    end

    local statusBarSizeY = UserInputService.StatusBarSize.Y

    local var15 = ContactsSyncWarningMessage.useIsVisible()

    local tbl4 = {
        layout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        }),
        contactsSyncWarning = if var15 then React.createElement(ContactsSyncWarningMessage.Component, { layoutOrder = -1 }) else nil
    }

    local ref = React.createRef()

    local function textChangeCallback(arg1)
        var8(arg1)
    end

    local element

    if #tbl2 ~= 0 then
        local createElement = Roact.createElement
        local var16 = SectionList
        local tbl5 = {
            ref = ref,
            sections = sections,
            renderSectionHeader = 0,
            renderItem = 0,
            initialNumToRender = 15,
            CanvasSize = 0,
            contentContainerStyle = 0,
            style = 0
        }

        if not (#var11 > 0) then
            func7 = nil
        end

        tbl5.renderSectionHeader = func7
        tbl5.renderItem = renderItem

        tbl5.CanvasSize = UDim2.new(1, 0, 0, #tbl2 * 73)
        tbl5.contentContainerStyle = { BackgroundTransparency = 1, BorderSizePixel = 0 }

        tbl5.style = {
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            LayoutOrder = 8,
            Size = UDim2.new(1, 0, 1, -80 - (if var5 then 0 else 48) - 36 - 16),
            ElasticBehavior = Enum.ElasticBehavior.Always
        }
        element = createElement(var16, tbl5)
    else
        element = Roact.createElement(ContactsEmptyList, { errorTextKey = TextKeys.NO_RESULTS, layoutOrder = 8 })
    end

    local tbl5 = {
        layout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        }),
        contactsSyncWarning = if var15 then React.createElement(ContactsSyncWarningMessage.Component, { layoutOrder = -1 }) else nil,
        spacer1 = if var15 then nil else Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 1 }),
        descriptionFrame = 0,
        spacer2 = 0,
        searchBarContainer = 0,
        spacer4 = 0,
        contactsList = 0
    }
    local var16

    if var15 then
        var16 = nil
    else
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl6 = {
            Size = UDim2.new(1, 0, 0, 80),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }

        local tbl7 = {
            textLayout = Roact.createElement("UIListLayout", {
                HorizontalAlignment = if FFlagQRCodeCopyUpdates and var13 then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            descriptionText = Roact.createElement(StyledTextLabel, {
                text = if FFlagQRCodeCopyUpdates and var13 then var4.contactsListTFEducationBlurb else var4.contactsListBlurb,
                automaticSize = Enum.AutomaticSize.Y,
                colorStyle = var2.Theme.TextDefault,
                fontStyle = var2.Font.Body,
                lineHeight = 1,
                size = UDim2.new(1, 0, 0, 0),
                maxSize = Vector2.new(0, 80),
                textXAlignment = if FFlagQRCodeCopyUpdates and var13 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
                textYAlignment = Enum.TextYAlignment.Center,
                layoutOrder = 1
            }),
            LearnMoreWebLink = var1
                and React.createElement(InputLabel, {
                    LayoutOrder = 2,
                    tag = "auto-y size-full-0",
                    RichText = true,
                    Text = `<u>{var4.learnMore}</u>`,
                    size = InputLabelSize.Large,
                    onActivated = var6
                })
        }
        var16 = createElement(str1, tbl6, tbl7)
    end

    tbl5.descriptionFrame = var16

    tbl5.spacer2 = if var15 then nil else Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, LayoutOrder = 3 })

    tbl5.searchBarContainer = Roact.createElement(ContactsListSearchBar, { height = 36, layoutOrder = 4, textChangeCallback = textChangeCallback })

    tbl5.spacer4 = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, LayoutOrder = 7 })

    tbl5.contactsList = element

    if tbl1.isFetching then
        for _, layoutOrder in { 1, 2, 3 } do
            tbl4["glimmer" .. layoutOrder] = Roact.createElement(ContactsGlimmer, { layoutOrder = layoutOrder })
        end
    elseif tbl1.hasUploadError and func5() then
        tbl4.errorModal = Roact.createElement(ContactsUploadErrorModal)
    elseif func5() then
        tbl4.emptyList = Roact.createElement(ContactsEmptyList)
    else
        tbl4 = tbl5
    end

    return Roact.createElement(FullPageModal, {
        title = var4.connectWithFriends,
        screenSize = tbl1.screenSize,
        marginSize = 0,
        distanceFromTop = statusBarSizeY,
        onCloseClicked = onCloseClicked,
        buttonStackProps = {
            buttons = func8(var4),
            buttonHeight = if var5 then 0 else 48,
            forcedFillDirection = Enum.FillDirection.Vertical
        }
    }, {
        hpm = Roact.createElement(
            HorizontalPageMargin,
            {
                size = UDim2.new(1, 0, 1, 0),
                position = UDim2.new(0, 0, 0, 0),
                backgroundTransparency = 1
            },
            {
                contentFrame = Roact.createElement("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, tbl4),
                gradientFrame = Roact.createElement("Frame", {
                    Position = UDim2.new(0, 0, 1, if var5 then 0 else -24),
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    ZIndex = 2
                }, {
                    gradient = Roact.createElement("UIGradient", {
                        Rotation = 270,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, var2.Theme.BackgroundUIDefault.Color), ColorSequenceKeypoint.new(1, var2.Theme.BackgroundUIDefault.Color) }),
                        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
                    })
                })
            }
        )
    })
end

return ContactsList
