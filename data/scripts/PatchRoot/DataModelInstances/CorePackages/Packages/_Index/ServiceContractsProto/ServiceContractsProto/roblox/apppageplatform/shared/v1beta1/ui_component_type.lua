-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local _typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

tbl1.UiComponentType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "UI_COMPONENT_TYPE_INVALID"
        elseif num1 == 1 then
            return "UI_COMPONENT_TYPE_FEED"
        elseif num1 == 10 then
            return "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL"
        elseif num1 == 11 then
            return "UI_COMPONENT_TYPE_COLLECTION_GRID"
        elseif num1 == 12 then
            return "UI_COMPONENT_TYPE_SINGLE_ITEM_COLLECTION"
        elseif num1 == 13 then
            return "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL_PLACEHOLDER"
        elseif num1 == 14 then
            return "UI_COMPONENT_TYPE_VARIABLE_ITEM_WIDTH_CAROUSEL"
        elseif num1 == 15 then
            return "UI_COMPONENT_TYPE_OPTION_SELECTOR_COLLECTION"
        elseif num1 == 17 then
            return "UI_COMPONENT_TYPE_COLLECTION_SLOTS_LAYOUT"
        elseif num1 == 100 then
            return "UI_COMPONENT_TYPE_TILE"
        elseif num1 == 101 then
            return "UI_COMPONENT_TYPE_GAME_TILE"
        elseif num1 == 102 then
            return "UI_COMPONENT_TYPE_SEE_ALL_TILE"
        elseif num1 == 103 then
            return "UI_COMPONENT_TYPE_BADGE_TILE"
        elseif num1 == 104 then
            return "UI_COMPONENT_TYPE_SONG_TILE"
        elseif num1 == 105 then
            return "UI_COMPONENT_TYPE_EVENT_TILE"
        elseif num1 == 106 then
            return "UI_COMPONENT_TYPE_PLACEHOLDER_TILE"
        elseif num1 == 107 then
            return "UI_COMPONENT_TYPE_SPONSORED_TWO_BY_ONE_TILE"
        elseif num1 == 108 then
            return "UI_COMPONENT_TYPE_SPONSORED_ONE_BY_TWO_TILE"
        elseif num1 == 109 then
            return "UI_COMPONENT_TYPE_USER_SEARCH_TILE"
        elseif num1 == 110 then
            return "UI_COMPONENT_TYPE_INTERACTABLE_TILE_WRAPPER"
        elseif num1 == 200 then
            return "UI_COMPONENT_TYPE_BUTTON"
        elseif num1 == 201 then
            return "UI_COMPONENT_TYPE_IMAGE"
        elseif num1 == 202 then
            return "UI_COMPONENT_TYPE_TEXT"
        elseif num1 == 203 then
            return "UI_COMPONENT_TYPE_VIEW"
        elseif num1 == 204 then
            return "UI_COMPONENT_TYPE_DIVIDER"
        elseif num1 == 205 then
            return "UI_COMPONENT_TYPE_DIALOG"
        elseif num1 == 206 then
            return "UI_COMPONENT_TYPE_TEXT_ICON_ROW"
        elseif num1 == 207 then
            return "UI_COMPONENT_TYPE_TEXT_PILL"
        elseif num1 == 208 then
            return "UI_COMPONENT_TYPE_SECTION_HEADER"
        elseif num1 == 209 then
            return "UI_COMPONENT_TYPE_SLOT_OVERLAY"
        elseif num1 == 210 then
            return "UI_COMPONENT_TYPE_TILE_FOOTER"
        elseif num1 == 211 then
            return "UI_COMPONENT_TYPE_ATTRIBUTION_ROW"
        end

        if num1 == 212 then
            return "UI_COMPONENT_TYPE_GAME_TILE_ACTIVE_FRIENDS_FOOTER"
        elseif num1 == 213 then
            return "UI_COMPONENT_TYPE_HERO_UNIT"
        elseif num1 == 214 then
            return "UI_COMPONENT_TYPE_HOLD_TO_PLAY"
        elseif num1 == 215 then
            return "UI_COMPONENT_TYPE_PLAY_BUTTON"
        elseif num1 == 216 then
            return "UI_COMPONENT_TYPE_COUNTDOWN_TEXT_ICON_ROW"
        elseif num1 == 217 then
            return "UI_COMPONENT_TYPE_INFO_TABLE"
        elseif num1 == 218 then
            return "UI_COMPONENT_TYPE_INFO_TABLE_CELL"
        elseif num1 == 219 then
            return "UI_COMPONENT_TYPE_CHIP"
        elseif num1 == 220 then
            return "UI_COMPONENT_TYPE_DUAL_ACTION_CHIP"
        elseif num1 == 221 then
            return "UI_COMPONENT_TYPE_EXPANDABLE_TEXT"
        elseif num1 == 222 then
            return "UI_COMPONENT_TYPE_ASSOCIATED_ITEMS_ROW"
        elseif num1 == 223 then
            return "UI_COMPONENT_TYPE_OVERFLOW_MENU"
        elseif num1 == 224 then
            return "UI_COMPONENT_TYPE_DETAILS_PAGE_IMAGE_HEADER"
        elseif num1 == 225 then
            return "UI_COMPONENT_TYPE_CARD"
        elseif num1 == 226 then
            return "UI_COMPONENT_TYPE_TABS"
        elseif num1 == 227 then
            return "UI_COMPONENT_TYPE_ACTION_BAR"
        elseif num1 == 228 then
            return "UI_COMPONENT_TYPE_ICON"
        elseif num1 == 229 then
            return "UI_COMPONENT_TYPE_CIRCLE_ICON"
        elseif num1 == 230 then
            return "UI_COMPONENT_TYPE_CONTENT_RATING_LABEL"
        elseif num1 == 231 then
            return "UI_COMPONENT_TYPE_PLAY_BUTTON_CONTEXTUAL_MESSAGE"
        elseif num1 == 232 then
            return "UI_COMPONENT_TYPE_MEDIA_GALLERY"
        elseif num1 == 233 then
            return "UI_COMPONENT_TYPE_CONTENT_ROW"
        elseif num1 == 234 then
            return "UI_COMPONENT_TYPE_LINK_TEXT"
        elseif num1 == 235 then
            return "UI_COMPONENT_TYPE_COACHMARK"
        elseif num1 == 236 then
            return "UI_COMPONENT_TYPE_BADGE"
        elseif num1 == 237 then
            return "UI_COMPONENT_TYPE_SUBSCRIPTION_CELL"
        elseif num1 == 238 then
            return "UI_COMPONENT_TYPE_SHEET_FULL_BLEED"
        elseif num1 == 239 then
            return "UI_COMPONENT_TYPE_SYSTEM_BANNER"
        elseif num1 == 240 then
            return "UI_COMPONENT_TYPE_PLAY_WITH_REWARD"
        elseif num1 == 241 then
            return "UI_COMPONENT_TYPE_ICON_BUTTON"
        elseif num1 == 242 then
            return "UI_COMPONENT_TYPE_AGE_CHECK_UPSELL_ROW"
        elseif num1 == 243 then
            return "UI_COMPONENT_TYPE_PAGE_HEADER"
        end

        if num1 == 244 then
            return "UI_COMPONENT_TYPE_AVATAR_GROUP"
        elseif num1 == 245 then
            return "UI_COMPONENT_TYPE_TOOLTIP"
        elseif num1 == 246 then
            return "UI_COMPONENT_TYPE_AI_OVERVIEW"
        elseif num1 == 247 then
            return "UI_COMPONENT_TYPE_SKELETON"
        elseif num1 == 248 then
            return "UI_COMPONENT_TYPE_PLACEHOLDER"
        elseif num1 == 249 then
            return "UI_COMPONENT_TYPE_PLACEHOLDER_WRAPPER"
        elseif num1 == 250 then
            return "UI_COMPONENT_TYPE_REVEAL_TEXT"
        elseif num1 == 251 then
            return "UI_COMPONENT_TYPE_SHIMMER_TEXT"
        elseif num1 == 252 then
            return "UI_COMPONENT_TYPE_APP_DOWNLOAD_BUTTON"
        elseif num1 == 253 then
            return "UI_COMPONENT_TYPE_LOGO"
        elseif num1 == 254 then
            return "UI_COMPONENT_TYPE_FEEDBACK_BANNER"
        elseif num1 == 255 then
            return "UI_COMPONENT_TYPE_GAME_SORT_DROP_DOWN"
        elseif num1 == 256 then
            return "UI_COMPONENT_TYPE_LAYERED_CONTAINER"
        elseif num1 == 257 then
            return "UI_COMPONENT_TYPE_BACKGROUND_BLUR"
        elseif num1 == 258 then
            return "UI_COMPONENT_TYPE_VIRTUAL_GAME_ITEM_TEXT"
        elseif num1 == 259 then
            return "UI_COMPONENT_TYPE_VIDEO_PLAYER"
        elseif num1 == 260 then
            return "UI_COMPONENT_TYPE_VERTICAL_LIST_WITH_IMPRESSIONS"
        elseif num1 == 261 then
            return "UI_COMPONENT_TYPE_REVEAL_ROWS_BUTTON_WITH_DIVIDER"
        elseif num1 == 262 then
            return "UI_COMPONENT_TYPE_HERO_UNIT_BOTTOM_ROW"
        elseif num1 == 263 then
            return "UI_COMPONENT_TYPE_HOME_USER_INFO_WIDGET"
        elseif num1 == 264 then
            return "UI_COMPONENT_TYPE_GAME_TILE_HIDDEN_STATE"
        elseif num1 == 265 then
            return "UI_COMPONENT_TYPE_PLUS_EARLY_ACCESS_UPSELL"
        elseif num1 == 266 then
            return "UI_COMPONENT_TYPE_TOGGLE"
        elseif num1 == 267 then
            return "UI_COMPONENT_TYPE_LIST_ROOT"
        elseif num1 == 268 then
            return "UI_COMPONENT_TYPE_LIST_ITEM"
        elseif num1 == 269 then
            return "UI_COMPONENT_TYPE_MARKDOWN_TEXT"
        elseif num1 == 270 then
            return "UI_COMPONENT_TYPE_SIGN_UP_FORM"
        elseif num1 == 271 then
            return "UI_COMPONENT_TYPE_BANNER_CONTEXT"
        elseif num1 == 272 then
            return "UI_COMPONENT_TYPE_VIEWPORT_VISIBILITY"
        elseif num1 == 273 then
            return "UI_COMPONENT_TYPE_PROGRESS"
        elseif num1 == 274 then
            return "UI_COMPONENT_TYPE_LINE_LIMITED_TEXT"
        elseif num1 == 275 then
            return "UI_COMPONENT_TYPE_CUSTOM_FORM"
        end

        if num1 == 276 then
            return "UI_COMPONENT_TYPE_ACCORDION"
        elseif num1 == 277 then
            return "UI_COMPONENT_TYPE_ACCORDION_ITEM"
        elseif num1 == 278 then
            return "UI_COMPONENT_TYPE_CONFIG_DRIVEN_FORM"
        elseif num1 == 279 then
            return "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ROOT"
        elseif num1 == 280 then
            return "UI_COMPONENT_TYPE_SEARCH_AUTOCOMPLETE_SUGGESTION"
        elseif num1 == 281 then
            return "UI_COMPONENT_TYPE_REACTIONS"
        elseif num1 == 282 then
            return "UI_COMPONENT_TYPE_BANNER"
        elseif num1 == 283 then
            return "UI_COMPONENT_TYPE_SHEET"
        elseif num1 == 284 then
            return "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ITEM"
        elseif num1 == 285 then
            return "UI_COMPONENT_TYPE_STATUS_BADGE"
        elseif num1 == 286 then
            return "UI_COMPONENT_TYPE_MURAL_SECTION"
        elseif num1 == 300 then
            return "UI_COMPONENT_TYPE_FOCUS_NAV_ACTIONS"
        elseif num1 == 400 then
            return "UI_COMPONENT_TYPE_FRAGMENT"
        elseif num1 == 401 then
            return "UI_COMPONENT_TYPE_EXPERIMENTAL"
        elseif num1 == 500 then
            return "UI_COMPONENT_TYPE_VERTICAL_FEED"
        elseif num1 == 600 then
            return "UI_COMPONENT_TYPE_CATALOG_VIRTUALIZED_FEED"
        elseif num1 == 601 then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_GROUP"
        elseif num1 == 602 then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_CAROUSEL"
        elseif num1 == 603 then
            return "UI_COMPONENT_TYPE_CATALOG_CATEGORY_MENU"
        elseif num1 == 604 then
            return "UI_COMPONENT_TYPE_CATALOG_HERO_UNIT"
        elseif num1 == 605 then
            return "UI_COMPONENT_TYPE_MARKETPLACE_FAVORITES_CATEGORY_MENU"
        elseif num1 == 606 then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_GRID"
        elseif num1 == 607 then
            return "UI_COMPONENT_TYPE_ITEM_MEDIA_HEADER"
        elseif num1 == 608 then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_CARD"
        elseif num1 == 700 then
            return "UI_COMPONENT_TYPE_FILTER_PILLS_CAROUSEL"
        elseif num1 == 701 then
            return "UI_COMPONENT_TYPE_PILL_TABS_CAROUSEL"
        elseif num1 == 800 then
            return "UI_COMPONENT_TYPE_USER_LIST"
        elseif num1 == 801 then
            return "UI_COMPONENT_TYPE_FRIEND_REQUEST_BUTTON"
        elseif num1 == 802 then
            return "UI_COMPONENT_TYPE_FRIEND_CAROUSEL"
        elseif num1 == 803 then
            return "UI_COMPONENT_TYPE_PYMK_CAROUSEL"
        elseif num1 == 804 then
            return "UI_COMPONENT_TYPE_FRIENDS_OWNED_CHIP"
        elseif num1 == 900 then
            return "UI_COMPONENT_TYPE_GROUP_FORUM_POST_PREVIEW"
        end

        if num1 == 901 then
            return "UI_COMPONENT_TYPE_GROUP_SIDEBAR"
        elseif num1 == 902 then
            return "UI_COMPONENT_TYPE_GROUP_SECTION"
        elseif num1 == 9999 then
            return "UI_COMPONENT_TYPE_MOCK_COMPONENT"
        end

        return nil
    end,
    toNumber = function(arg1): number
        if arg1 == "UI_COMPONENT_TYPE_INVALID" then
            return 0
        elseif arg1 == "UI_COMPONENT_TYPE_FEED" then
            return 1
        elseif arg1 == "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL" then
            return 10
        elseif arg1 == "UI_COMPONENT_TYPE_COLLECTION_GRID" then
            return 11
        elseif arg1 == "UI_COMPONENT_TYPE_SINGLE_ITEM_COLLECTION" then
            return 12
        elseif arg1 == "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL_PLACEHOLDER" then
            return 13
        elseif arg1 == "UI_COMPONENT_TYPE_VARIABLE_ITEM_WIDTH_CAROUSEL" then
            return 14
        elseif arg1 == "UI_COMPONENT_TYPE_OPTION_SELECTOR_COLLECTION" then
            return 15
        elseif arg1 == "UI_COMPONENT_TYPE_COLLECTION_SLOTS_LAYOUT" then
            return 17
        elseif arg1 == "UI_COMPONENT_TYPE_TILE" then
            return 100
        elseif arg1 == "UI_COMPONENT_TYPE_GAME_TILE" then
            return 101
        elseif arg1 == "UI_COMPONENT_TYPE_SEE_ALL_TILE" then
            return 102
        elseif arg1 == "UI_COMPONENT_TYPE_BADGE_TILE" then
            return 103
        elseif arg1 == "UI_COMPONENT_TYPE_SONG_TILE" then
            return 104
        elseif arg1 == "UI_COMPONENT_TYPE_EVENT_TILE" then
            return 105
        elseif arg1 == "UI_COMPONENT_TYPE_PLACEHOLDER_TILE" then
            return 106
        elseif arg1 == "UI_COMPONENT_TYPE_SPONSORED_TWO_BY_ONE_TILE" then
            return 107
        elseif arg1 == "UI_COMPONENT_TYPE_SPONSORED_ONE_BY_TWO_TILE" then
            return 108
        elseif arg1 == "UI_COMPONENT_TYPE_USER_SEARCH_TILE" then
            return 109
        elseif arg1 == "UI_COMPONENT_TYPE_INTERACTABLE_TILE_WRAPPER" then
            return 110
        elseif arg1 == "UI_COMPONENT_TYPE_BUTTON" then
            return 200
        elseif arg1 == "UI_COMPONENT_TYPE_IMAGE" then
            return 201
        elseif arg1 == "UI_COMPONENT_TYPE_TEXT" then
            return 202
        elseif arg1 == "UI_COMPONENT_TYPE_VIEW" then
            return 203
        elseif arg1 == "UI_COMPONENT_TYPE_DIVIDER" then
            return 204
        elseif arg1 == "UI_COMPONENT_TYPE_DIALOG" then
            return 205
        elseif arg1 == "UI_COMPONENT_TYPE_TEXT_ICON_ROW" then
            return 206
        elseif arg1 == "UI_COMPONENT_TYPE_TEXT_PILL" then
            return 207
        elseif arg1 == "UI_COMPONENT_TYPE_SECTION_HEADER" then
            return 208
        elseif arg1 == "UI_COMPONENT_TYPE_SLOT_OVERLAY" then
            return 209
        elseif arg1 == "UI_COMPONENT_TYPE_TILE_FOOTER" then
            return 210
        elseif arg1 == "UI_COMPONENT_TYPE_ATTRIBUTION_ROW" then
            return 211
        end

        if arg1 == "UI_COMPONENT_TYPE_GAME_TILE_ACTIVE_FRIENDS_FOOTER" then
            return 212
        elseif arg1 == "UI_COMPONENT_TYPE_HERO_UNIT" then
            return 213
        elseif arg1 == "UI_COMPONENT_TYPE_HOLD_TO_PLAY" then
            return 214
        elseif arg1 == "UI_COMPONENT_TYPE_PLAY_BUTTON" then
            return 215
        elseif arg1 == "UI_COMPONENT_TYPE_COUNTDOWN_TEXT_ICON_ROW" then
            return 216
        elseif arg1 == "UI_COMPONENT_TYPE_INFO_TABLE" then
            return 217
        elseif arg1 == "UI_COMPONENT_TYPE_INFO_TABLE_CELL" then
            return 218
        elseif arg1 == "UI_COMPONENT_TYPE_CHIP" then
            return 219
        elseif arg1 == "UI_COMPONENT_TYPE_DUAL_ACTION_CHIP" then
            return 220
        elseif arg1 == "UI_COMPONENT_TYPE_EXPANDABLE_TEXT" then
            return 221
        elseif arg1 == "UI_COMPONENT_TYPE_ASSOCIATED_ITEMS_ROW" then
            return 222
        elseif arg1 == "UI_COMPONENT_TYPE_OVERFLOW_MENU" then
            return 223
        elseif arg1 == "UI_COMPONENT_TYPE_DETAILS_PAGE_IMAGE_HEADER" then
            return 224
        elseif arg1 == "UI_COMPONENT_TYPE_CARD" then
            return 225
        elseif arg1 == "UI_COMPONENT_TYPE_TABS" then
            return 226
        elseif arg1 == "UI_COMPONENT_TYPE_ACTION_BAR" then
            return 227
        elseif arg1 == "UI_COMPONENT_TYPE_ICON" then
            return 228
        elseif arg1 == "UI_COMPONENT_TYPE_CIRCLE_ICON" then
            return 229
        elseif arg1 == "UI_COMPONENT_TYPE_CONTENT_RATING_LABEL" then
            return 230
        elseif arg1 == "UI_COMPONENT_TYPE_PLAY_BUTTON_CONTEXTUAL_MESSAGE" then
            return 231
        elseif arg1 == "UI_COMPONENT_TYPE_MEDIA_GALLERY" then
            return 232
        elseif arg1 == "UI_COMPONENT_TYPE_CONTENT_ROW" then
            return 233
        elseif arg1 == "UI_COMPONENT_TYPE_LINK_TEXT" then
            return 234
        elseif arg1 == "UI_COMPONENT_TYPE_COACHMARK" then
            return 235
        elseif arg1 == "UI_COMPONENT_TYPE_BADGE" then
            return 236
        elseif arg1 == "UI_COMPONENT_TYPE_SUBSCRIPTION_CELL" then
            return 237
        elseif arg1 == "UI_COMPONENT_TYPE_SHEET_FULL_BLEED" then
            return 238
        elseif arg1 == "UI_COMPONENT_TYPE_SYSTEM_BANNER" then
            return 239
        elseif arg1 == "UI_COMPONENT_TYPE_PLAY_WITH_REWARD" then
            return 240
        elseif arg1 == "UI_COMPONENT_TYPE_ICON_BUTTON" then
            return 241
        elseif arg1 == "UI_COMPONENT_TYPE_AGE_CHECK_UPSELL_ROW" then
            return 242
        elseif arg1 == "UI_COMPONENT_TYPE_PAGE_HEADER" then
            return 243
        end

        if arg1 == "UI_COMPONENT_TYPE_AVATAR_GROUP" then
            return 244
        elseif arg1 == "UI_COMPONENT_TYPE_TOOLTIP" then
            return 245
        elseif arg1 == "UI_COMPONENT_TYPE_AI_OVERVIEW" then
            return 246
        elseif arg1 == "UI_COMPONENT_TYPE_SKELETON" then
            return 247
        elseif arg1 == "UI_COMPONENT_TYPE_PLACEHOLDER" then
            return 248
        elseif arg1 == "UI_COMPONENT_TYPE_PLACEHOLDER_WRAPPER" then
            return 249
        elseif arg1 == "UI_COMPONENT_TYPE_REVEAL_TEXT" then
            return 250
        elseif arg1 == "UI_COMPONENT_TYPE_SHIMMER_TEXT" then
            return 251
        elseif arg1 == "UI_COMPONENT_TYPE_APP_DOWNLOAD_BUTTON" then
            return 252
        elseif arg1 == "UI_COMPONENT_TYPE_LOGO" then
            return 253
        elseif arg1 == "UI_COMPONENT_TYPE_FEEDBACK_BANNER" then
            return 254
        elseif arg1 == "UI_COMPONENT_TYPE_GAME_SORT_DROP_DOWN" then
            return 255
        elseif arg1 == "UI_COMPONENT_TYPE_LAYERED_CONTAINER" then
            return 256
        elseif arg1 == "UI_COMPONENT_TYPE_BACKGROUND_BLUR" then
            return 257
        elseif arg1 == "UI_COMPONENT_TYPE_VIRTUAL_GAME_ITEM_TEXT" then
            return 258
        elseif arg1 == "UI_COMPONENT_TYPE_VIDEO_PLAYER" then
            return 259
        elseif arg1 == "UI_COMPONENT_TYPE_VERTICAL_LIST_WITH_IMPRESSIONS" then
            return 260
        elseif arg1 == "UI_COMPONENT_TYPE_REVEAL_ROWS_BUTTON_WITH_DIVIDER" then
            return 261
        elseif arg1 == "UI_COMPONENT_TYPE_HERO_UNIT_BOTTOM_ROW" then
            return 262
        elseif arg1 == "UI_COMPONENT_TYPE_HOME_USER_INFO_WIDGET" then
            return 263
        elseif arg1 == "UI_COMPONENT_TYPE_GAME_TILE_HIDDEN_STATE" then
            return 264
        elseif arg1 == "UI_COMPONENT_TYPE_PLUS_EARLY_ACCESS_UPSELL" then
            return 265
        elseif arg1 == "UI_COMPONENT_TYPE_TOGGLE" then
            return 266
        elseif arg1 == "UI_COMPONENT_TYPE_LIST_ROOT" then
            return 267
        elseif arg1 == "UI_COMPONENT_TYPE_LIST_ITEM" then
            return 268
        elseif arg1 == "UI_COMPONENT_TYPE_MARKDOWN_TEXT" then
            return 269
        elseif arg1 == "UI_COMPONENT_TYPE_SIGN_UP_FORM" then
            return 270
        elseif arg1 == "UI_COMPONENT_TYPE_BANNER_CONTEXT" then
            return 271
        elseif arg1 == "UI_COMPONENT_TYPE_VIEWPORT_VISIBILITY" then
            return 272
        elseif arg1 == "UI_COMPONENT_TYPE_PROGRESS" then
            return 273
        elseif arg1 == "UI_COMPONENT_TYPE_LINE_LIMITED_TEXT" then
            return 274
        elseif arg1 == "UI_COMPONENT_TYPE_CUSTOM_FORM" then
            return 275
        end

        if arg1 == "UI_COMPONENT_TYPE_ACCORDION" then
            return 276
        elseif arg1 == "UI_COMPONENT_TYPE_ACCORDION_ITEM" then
            return 277
        elseif arg1 == "UI_COMPONENT_TYPE_CONFIG_DRIVEN_FORM" then
            return 278
        elseif arg1 == "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ROOT" then
            return 279
        elseif arg1 == "UI_COMPONENT_TYPE_SEARCH_AUTOCOMPLETE_SUGGESTION" then
            return 280
        elseif arg1 == "UI_COMPONENT_TYPE_REACTIONS" then
            return 281
        elseif arg1 == "UI_COMPONENT_TYPE_BANNER" then
            return 282
        elseif arg1 == "UI_COMPONENT_TYPE_SHEET" then
            return 283
        elseif arg1 == "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ITEM" then
            return 284
        elseif arg1 == "UI_COMPONENT_TYPE_STATUS_BADGE" then
            return 285
        elseif arg1 == "UI_COMPONENT_TYPE_MURAL_SECTION" then
            return 286
        elseif arg1 == "UI_COMPONENT_TYPE_FOCUS_NAV_ACTIONS" then
            return 300
        elseif arg1 == "UI_COMPONENT_TYPE_FRAGMENT" then
            return 400
        elseif arg1 == "UI_COMPONENT_TYPE_EXPERIMENTAL" then
            return 401
        elseif arg1 == "UI_COMPONENT_TYPE_VERTICAL_FEED" then
            return 500
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_VIRTUALIZED_FEED" then
            return 600
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_GROUP" then
            return 601
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_CAROUSEL" then
            return 602
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_CATEGORY_MENU" then
            return 603
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_HERO_UNIT" then
            return 604
        elseif arg1 == "UI_COMPONENT_TYPE_MARKETPLACE_FAVORITES_CATEGORY_MENU" then
            return 605
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_GRID" then
            return 606
        elseif arg1 == "UI_COMPONENT_TYPE_ITEM_MEDIA_HEADER" then
            return 607
        elseif arg1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_CARD" then
            return 608
        elseif arg1 == "UI_COMPONENT_TYPE_FILTER_PILLS_CAROUSEL" then
            return 700
        elseif arg1 == "UI_COMPONENT_TYPE_PILL_TABS_CAROUSEL" then
            return 701
        elseif arg1 == "UI_COMPONENT_TYPE_USER_LIST" then
            return 800
        elseif arg1 == "UI_COMPONENT_TYPE_FRIEND_REQUEST_BUTTON" then
            return 801
        elseif arg1 == "UI_COMPONENT_TYPE_FRIEND_CAROUSEL" then
            return 802
        elseif arg1 == "UI_COMPONENT_TYPE_PYMK_CAROUSEL" then
            return 803
        elseif arg1 == "UI_COMPONENT_TYPE_FRIENDS_OWNED_CHIP" then
            return 804
        elseif arg1 == "UI_COMPONENT_TYPE_GROUP_FORUM_POST_PREVIEW" then
            return 900
        end

        if arg1 == "UI_COMPONENT_TYPE_GROUP_SIDEBAR" then
            return 901
        elseif arg1 == "UI_COMPONENT_TYPE_GROUP_SECTION" then
            return 902
        elseif arg1 == "UI_COMPONENT_TYPE_MOCK_COMPONENT" then
            return 9999
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "UI_COMPONENT_TYPE_INVALID" then
            return "UI_COMPONENT_TYPE_INVALID"
        elseif str1 == "UI_COMPONENT_TYPE_FEED" then
            return "UI_COMPONENT_TYPE_FEED"
        elseif str1 == "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL" then
            return "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_COLLECTION_GRID" then
            return "UI_COMPONENT_TYPE_COLLECTION_GRID"
        elseif str1 == "UI_COMPONENT_TYPE_SINGLE_ITEM_COLLECTION" then
            return "UI_COMPONENT_TYPE_SINGLE_ITEM_COLLECTION"
        elseif str1 == "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL_PLACEHOLDER" then
            return "UI_COMPONENT_TYPE_COLLECTION_CAROUSEL_PLACEHOLDER"
        elseif str1 == "UI_COMPONENT_TYPE_VARIABLE_ITEM_WIDTH_CAROUSEL" then
            return "UI_COMPONENT_TYPE_VARIABLE_ITEM_WIDTH_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_OPTION_SELECTOR_COLLECTION" then
            return "UI_COMPONENT_TYPE_OPTION_SELECTOR_COLLECTION"
        elseif str1 == "UI_COMPONENT_TYPE_COLLECTION_SLOTS_LAYOUT" then
            return "UI_COMPONENT_TYPE_COLLECTION_SLOTS_LAYOUT"
        elseif str1 == "UI_COMPONENT_TYPE_TILE" then
            return "UI_COMPONENT_TYPE_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_GAME_TILE" then
            return "UI_COMPONENT_TYPE_GAME_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_SEE_ALL_TILE" then
            return "UI_COMPONENT_TYPE_SEE_ALL_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_BADGE_TILE" then
            return "UI_COMPONENT_TYPE_BADGE_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_SONG_TILE" then
            return "UI_COMPONENT_TYPE_SONG_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_EVENT_TILE" then
            return "UI_COMPONENT_TYPE_EVENT_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_PLACEHOLDER_TILE" then
            return "UI_COMPONENT_TYPE_PLACEHOLDER_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_SPONSORED_TWO_BY_ONE_TILE" then
            return "UI_COMPONENT_TYPE_SPONSORED_TWO_BY_ONE_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_SPONSORED_ONE_BY_TWO_TILE" then
            return "UI_COMPONENT_TYPE_SPONSORED_ONE_BY_TWO_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_USER_SEARCH_TILE" then
            return "UI_COMPONENT_TYPE_USER_SEARCH_TILE"
        elseif str1 == "UI_COMPONENT_TYPE_INTERACTABLE_TILE_WRAPPER" then
            return "UI_COMPONENT_TYPE_INTERACTABLE_TILE_WRAPPER"
        elseif str1 == "UI_COMPONENT_TYPE_BUTTON" then
            return "UI_COMPONENT_TYPE_BUTTON"
        elseif str1 == "UI_COMPONENT_TYPE_IMAGE" then
            return "UI_COMPONENT_TYPE_IMAGE"
        elseif str1 == "UI_COMPONENT_TYPE_TEXT" then
            return "UI_COMPONENT_TYPE_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_VIEW" then
            return "UI_COMPONENT_TYPE_VIEW"
        elseif str1 == "UI_COMPONENT_TYPE_DIVIDER" then
            return "UI_COMPONENT_TYPE_DIVIDER"
        elseif str1 == "UI_COMPONENT_TYPE_DIALOG" then
            return "UI_COMPONENT_TYPE_DIALOG"
        elseif str1 == "UI_COMPONENT_TYPE_TEXT_ICON_ROW" then
            return "UI_COMPONENT_TYPE_TEXT_ICON_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_TEXT_PILL" then
            return "UI_COMPONENT_TYPE_TEXT_PILL"
        elseif str1 == "UI_COMPONENT_TYPE_SECTION_HEADER" then
            return "UI_COMPONENT_TYPE_SECTION_HEADER"
        elseif str1 == "UI_COMPONENT_TYPE_SLOT_OVERLAY" then
            return "UI_COMPONENT_TYPE_SLOT_OVERLAY"
        elseif str1 == "UI_COMPONENT_TYPE_TILE_FOOTER" then
            return "UI_COMPONENT_TYPE_TILE_FOOTER"
        elseif str1 == "UI_COMPONENT_TYPE_ATTRIBUTION_ROW" then
            return "UI_COMPONENT_TYPE_ATTRIBUTION_ROW"
        end

        if str1 == "UI_COMPONENT_TYPE_GAME_TILE_ACTIVE_FRIENDS_FOOTER" then
            return "UI_COMPONENT_TYPE_GAME_TILE_ACTIVE_FRIENDS_FOOTER"
        elseif str1 == "UI_COMPONENT_TYPE_HERO_UNIT" then
            return "UI_COMPONENT_TYPE_HERO_UNIT"
        elseif str1 == "UI_COMPONENT_TYPE_HOLD_TO_PLAY" then
            return "UI_COMPONENT_TYPE_HOLD_TO_PLAY"
        elseif str1 == "UI_COMPONENT_TYPE_PLAY_BUTTON" then
            return "UI_COMPONENT_TYPE_PLAY_BUTTON"
        elseif str1 == "UI_COMPONENT_TYPE_COUNTDOWN_TEXT_ICON_ROW" then
            return "UI_COMPONENT_TYPE_COUNTDOWN_TEXT_ICON_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_INFO_TABLE" then
            return "UI_COMPONENT_TYPE_INFO_TABLE"
        elseif str1 == "UI_COMPONENT_TYPE_INFO_TABLE_CELL" then
            return "UI_COMPONENT_TYPE_INFO_TABLE_CELL"
        elseif str1 == "UI_COMPONENT_TYPE_CHIP" then
            return "UI_COMPONENT_TYPE_CHIP"
        elseif str1 == "UI_COMPONENT_TYPE_DUAL_ACTION_CHIP" then
            return "UI_COMPONENT_TYPE_DUAL_ACTION_CHIP"
        elseif str1 == "UI_COMPONENT_TYPE_EXPANDABLE_TEXT" then
            return "UI_COMPONENT_TYPE_EXPANDABLE_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_ASSOCIATED_ITEMS_ROW" then
            return "UI_COMPONENT_TYPE_ASSOCIATED_ITEMS_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_OVERFLOW_MENU" then
            return "UI_COMPONENT_TYPE_OVERFLOW_MENU"
        elseif str1 == "UI_COMPONENT_TYPE_DETAILS_PAGE_IMAGE_HEADER" then
            return "UI_COMPONENT_TYPE_DETAILS_PAGE_IMAGE_HEADER"
        elseif str1 == "UI_COMPONENT_TYPE_CARD" then
            return "UI_COMPONENT_TYPE_CARD"
        elseif str1 == "UI_COMPONENT_TYPE_TABS" then
            return "UI_COMPONENT_TYPE_TABS"
        elseif str1 == "UI_COMPONENT_TYPE_ACTION_BAR" then
            return "UI_COMPONENT_TYPE_ACTION_BAR"
        elseif str1 == "UI_COMPONENT_TYPE_ICON" then
            return "UI_COMPONENT_TYPE_ICON"
        elseif str1 == "UI_COMPONENT_TYPE_CIRCLE_ICON" then
            return "UI_COMPONENT_TYPE_CIRCLE_ICON"
        elseif str1 == "UI_COMPONENT_TYPE_CONTENT_RATING_LABEL" then
            return "UI_COMPONENT_TYPE_CONTENT_RATING_LABEL"
        elseif str1 == "UI_COMPONENT_TYPE_PLAY_BUTTON_CONTEXTUAL_MESSAGE" then
            return "UI_COMPONENT_TYPE_PLAY_BUTTON_CONTEXTUAL_MESSAGE"
        elseif str1 == "UI_COMPONENT_TYPE_MEDIA_GALLERY" then
            return "UI_COMPONENT_TYPE_MEDIA_GALLERY"
        elseif str1 == "UI_COMPONENT_TYPE_CONTENT_ROW" then
            return "UI_COMPONENT_TYPE_CONTENT_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_LINK_TEXT" then
            return "UI_COMPONENT_TYPE_LINK_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_COACHMARK" then
            return "UI_COMPONENT_TYPE_COACHMARK"
        elseif str1 == "UI_COMPONENT_TYPE_BADGE" then
            return "UI_COMPONENT_TYPE_BADGE"
        elseif str1 == "UI_COMPONENT_TYPE_SUBSCRIPTION_CELL" then
            return "UI_COMPONENT_TYPE_SUBSCRIPTION_CELL"
        elseif str1 == "UI_COMPONENT_TYPE_SHEET_FULL_BLEED" then
            return "UI_COMPONENT_TYPE_SHEET_FULL_BLEED"
        elseif str1 == "UI_COMPONENT_TYPE_SYSTEM_BANNER" then
            return "UI_COMPONENT_TYPE_SYSTEM_BANNER"
        elseif str1 == "UI_COMPONENT_TYPE_PLAY_WITH_REWARD" then
            return "UI_COMPONENT_TYPE_PLAY_WITH_REWARD"
        elseif str1 == "UI_COMPONENT_TYPE_ICON_BUTTON" then
            return "UI_COMPONENT_TYPE_ICON_BUTTON"
        elseif str1 == "UI_COMPONENT_TYPE_AGE_CHECK_UPSELL_ROW" then
            return "UI_COMPONENT_TYPE_AGE_CHECK_UPSELL_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_PAGE_HEADER" then
            return "UI_COMPONENT_TYPE_PAGE_HEADER"
        end

        if str1 == "UI_COMPONENT_TYPE_AVATAR_GROUP" then
            return "UI_COMPONENT_TYPE_AVATAR_GROUP"
        elseif str1 == "UI_COMPONENT_TYPE_TOOLTIP" then
            return "UI_COMPONENT_TYPE_TOOLTIP"
        elseif str1 == "UI_COMPONENT_TYPE_AI_OVERVIEW" then
            return "UI_COMPONENT_TYPE_AI_OVERVIEW"
        elseif str1 == "UI_COMPONENT_TYPE_SKELETON" then
            return "UI_COMPONENT_TYPE_SKELETON"
        elseif str1 == "UI_COMPONENT_TYPE_PLACEHOLDER" then
            return "UI_COMPONENT_TYPE_PLACEHOLDER"
        elseif str1 == "UI_COMPONENT_TYPE_PLACEHOLDER_WRAPPER" then
            return "UI_COMPONENT_TYPE_PLACEHOLDER_WRAPPER"
        elseif str1 == "UI_COMPONENT_TYPE_REVEAL_TEXT" then
            return "UI_COMPONENT_TYPE_REVEAL_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_SHIMMER_TEXT" then
            return "UI_COMPONENT_TYPE_SHIMMER_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_APP_DOWNLOAD_BUTTON" then
            return "UI_COMPONENT_TYPE_APP_DOWNLOAD_BUTTON"
        elseif str1 == "UI_COMPONENT_TYPE_LOGO" then
            return "UI_COMPONENT_TYPE_LOGO"
        elseif str1 == "UI_COMPONENT_TYPE_FEEDBACK_BANNER" then
            return "UI_COMPONENT_TYPE_FEEDBACK_BANNER"
        elseif str1 == "UI_COMPONENT_TYPE_GAME_SORT_DROP_DOWN" then
            return "UI_COMPONENT_TYPE_GAME_SORT_DROP_DOWN"
        elseif str1 == "UI_COMPONENT_TYPE_LAYERED_CONTAINER" then
            return "UI_COMPONENT_TYPE_LAYERED_CONTAINER"
        elseif str1 == "UI_COMPONENT_TYPE_BACKGROUND_BLUR" then
            return "UI_COMPONENT_TYPE_BACKGROUND_BLUR"
        elseif str1 == "UI_COMPONENT_TYPE_VIRTUAL_GAME_ITEM_TEXT" then
            return "UI_COMPONENT_TYPE_VIRTUAL_GAME_ITEM_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_VIDEO_PLAYER" then
            return "UI_COMPONENT_TYPE_VIDEO_PLAYER"
        elseif str1 == "UI_COMPONENT_TYPE_VERTICAL_LIST_WITH_IMPRESSIONS" then
            return "UI_COMPONENT_TYPE_VERTICAL_LIST_WITH_IMPRESSIONS"
        elseif str1 == "UI_COMPONENT_TYPE_REVEAL_ROWS_BUTTON_WITH_DIVIDER" then
            return "UI_COMPONENT_TYPE_REVEAL_ROWS_BUTTON_WITH_DIVIDER"
        elseif str1 == "UI_COMPONENT_TYPE_HERO_UNIT_BOTTOM_ROW" then
            return "UI_COMPONENT_TYPE_HERO_UNIT_BOTTOM_ROW"
        elseif str1 == "UI_COMPONENT_TYPE_HOME_USER_INFO_WIDGET" then
            return "UI_COMPONENT_TYPE_HOME_USER_INFO_WIDGET"
        elseif str1 == "UI_COMPONENT_TYPE_GAME_TILE_HIDDEN_STATE" then
            return "UI_COMPONENT_TYPE_GAME_TILE_HIDDEN_STATE"
        elseif str1 == "UI_COMPONENT_TYPE_PLUS_EARLY_ACCESS_UPSELL" then
            return "UI_COMPONENT_TYPE_PLUS_EARLY_ACCESS_UPSELL"
        elseif str1 == "UI_COMPONENT_TYPE_TOGGLE" then
            return "UI_COMPONENT_TYPE_TOGGLE"
        elseif str1 == "UI_COMPONENT_TYPE_LIST_ROOT" then
            return "UI_COMPONENT_TYPE_LIST_ROOT"
        elseif str1 == "UI_COMPONENT_TYPE_LIST_ITEM" then
            return "UI_COMPONENT_TYPE_LIST_ITEM"
        elseif str1 == "UI_COMPONENT_TYPE_MARKDOWN_TEXT" then
            return "UI_COMPONENT_TYPE_MARKDOWN_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_SIGN_UP_FORM" then
            return "UI_COMPONENT_TYPE_SIGN_UP_FORM"
        elseif str1 == "UI_COMPONENT_TYPE_BANNER_CONTEXT" then
            return "UI_COMPONENT_TYPE_BANNER_CONTEXT"
        elseif str1 == "UI_COMPONENT_TYPE_VIEWPORT_VISIBILITY" then
            return "UI_COMPONENT_TYPE_VIEWPORT_VISIBILITY"
        elseif str1 == "UI_COMPONENT_TYPE_PROGRESS" then
            return "UI_COMPONENT_TYPE_PROGRESS"
        elseif str1 == "UI_COMPONENT_TYPE_LINE_LIMITED_TEXT" then
            return "UI_COMPONENT_TYPE_LINE_LIMITED_TEXT"
        elseif str1 == "UI_COMPONENT_TYPE_CUSTOM_FORM" then
            return "UI_COMPONENT_TYPE_CUSTOM_FORM"
        end

        if str1 == "UI_COMPONENT_TYPE_ACCORDION" then
            return "UI_COMPONENT_TYPE_ACCORDION"
        elseif str1 == "UI_COMPONENT_TYPE_ACCORDION_ITEM" then
            return "UI_COMPONENT_TYPE_ACCORDION_ITEM"
        elseif str1 == "UI_COMPONENT_TYPE_CONFIG_DRIVEN_FORM" then
            return "UI_COMPONENT_TYPE_CONFIG_DRIVEN_FORM"
        elseif str1 == "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ROOT" then
            return "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ROOT"
        elseif str1 == "UI_COMPONENT_TYPE_SEARCH_AUTOCOMPLETE_SUGGESTION" then
            return "UI_COMPONENT_TYPE_SEARCH_AUTOCOMPLETE_SUGGESTION"
        elseif str1 == "UI_COMPONENT_TYPE_REACTIONS" then
            return "UI_COMPONENT_TYPE_REACTIONS"
        elseif str1 == "UI_COMPONENT_TYPE_BANNER" then
            return "UI_COMPONENT_TYPE_BANNER"
        elseif str1 == "UI_COMPONENT_TYPE_SHEET" then
            return "UI_COMPONENT_TYPE_SHEET"
        elseif str1 == "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ITEM" then
            return "UI_COMPONENT_TYPE_EXPANDABLE_LIST_ITEM"
        elseif str1 == "UI_COMPONENT_TYPE_STATUS_BADGE" then
            return "UI_COMPONENT_TYPE_STATUS_BADGE"
        elseif str1 == "UI_COMPONENT_TYPE_MURAL_SECTION" then
            return "UI_COMPONENT_TYPE_MURAL_SECTION"
        elseif str1 == "UI_COMPONENT_TYPE_FOCUS_NAV_ACTIONS" then
            return "UI_COMPONENT_TYPE_FOCUS_NAV_ACTIONS"
        elseif str1 == "UI_COMPONENT_TYPE_FRAGMENT" then
            return "UI_COMPONENT_TYPE_FRAGMENT"
        elseif str1 == "UI_COMPONENT_TYPE_EXPERIMENTAL" then
            return "UI_COMPONENT_TYPE_EXPERIMENTAL"
        elseif str1 == "UI_COMPONENT_TYPE_VERTICAL_FEED" then
            return "UI_COMPONENT_TYPE_VERTICAL_FEED"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_VIRTUALIZED_FEED" then
            return "UI_COMPONENT_TYPE_CATALOG_VIRTUALIZED_FEED"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_GROUP" then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_GROUP"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_CAROUSEL" then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_CATEGORY_MENU" then
            return "UI_COMPONENT_TYPE_CATALOG_CATEGORY_MENU"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_HERO_UNIT" then
            return "UI_COMPONENT_TYPE_CATALOG_HERO_UNIT"
        elseif str1 == "UI_COMPONENT_TYPE_MARKETPLACE_FAVORITES_CATEGORY_MENU" then
            return "UI_COMPONENT_TYPE_MARKETPLACE_FAVORITES_CATEGORY_MENU"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_GRID" then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_GRID"
        elseif str1 == "UI_COMPONENT_TYPE_ITEM_MEDIA_HEADER" then
            return "UI_COMPONENT_TYPE_ITEM_MEDIA_HEADER"
        elseif str1 == "UI_COMPONENT_TYPE_CATALOG_ITEM_CARD" then
            return "UI_COMPONENT_TYPE_CATALOG_ITEM_CARD"
        elseif str1 == "UI_COMPONENT_TYPE_FILTER_PILLS_CAROUSEL" then
            return "UI_COMPONENT_TYPE_FILTER_PILLS_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_PILL_TABS_CAROUSEL" then
            return "UI_COMPONENT_TYPE_PILL_TABS_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_USER_LIST" then
            return "UI_COMPONENT_TYPE_USER_LIST"
        elseif str1 == "UI_COMPONENT_TYPE_FRIEND_REQUEST_BUTTON" then
            return "UI_COMPONENT_TYPE_FRIEND_REQUEST_BUTTON"
        elseif str1 == "UI_COMPONENT_TYPE_FRIEND_CAROUSEL" then
            return "UI_COMPONENT_TYPE_FRIEND_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_PYMK_CAROUSEL" then
            return "UI_COMPONENT_TYPE_PYMK_CAROUSEL"
        elseif str1 == "UI_COMPONENT_TYPE_FRIENDS_OWNED_CHIP" then
            return "UI_COMPONENT_TYPE_FRIENDS_OWNED_CHIP"
        elseif str1 == "UI_COMPONENT_TYPE_GROUP_FORUM_POST_PREVIEW" then
            return "UI_COMPONENT_TYPE_GROUP_FORUM_POST_PREVIEW"
        end

        if str1 == "UI_COMPONENT_TYPE_GROUP_SIDEBAR" then
            return "UI_COMPONENT_TYPE_GROUP_SIDEBAR"
        elseif str1 == "UI_COMPONENT_TYPE_GROUP_SECTION" then
            return "UI_COMPONENT_TYPE_GROUP_SECTION"
        elseif str1 == "UI_COMPONENT_TYPE_MOCK_COMPONENT" then
            return "UI_COMPONENT_TYPE_MOCK_COMPONENT"
        end

        return nil
    end
}

return {
    UiComponentType = tbl1.UiComponentType
}
