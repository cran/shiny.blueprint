#' Documentation template
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param ... Component props and children. See the official Blueprint docs for details.
#' @param value Initial value.
#'
#' @return
#' Object with `shiny.tag` class suitable for use in the UI of a Shiny app.
#'
#' @keywords internal
#' @name component
NULL

component <- function(name) {
  function(...) {
    shiny.react::reactElement(
      module = "@blueprintjs/core",
      name = name,
      props = shiny.react::asProps(...),
      deps = blueprintDependency()
    )
  }
}

properties <- function(name) {
  function(...) {
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(...),
      deps = blueprintDependency()
    )
  }
}

input <- function(name, defaultValue) {
  function(inputId, ..., value = defaultValue) {
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(inputId = inputId, ..., value = value),
      deps = blueprintDependency()
    )
  }
}

inputWithoutDefault <- function(name) {
  function(inputId, ...) {
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(inputId = inputId, ...),
      deps = blueprintDependency()
    )
  }
}

tree <- function(name) {
  function(inputId, data, ...) {
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(inputId = inputId, data = data, ...),
      deps = blueprintDependency()
    )
  }
}

select <- function(name) {
  function(
    inputId,
    items,
    selected = NULL,
    ...,
    noResults = "No results."
  ) {
    checkmate::assert_string(inputId)
    checkmate::assert(
      checkmate::check_character(items),
      checkmate::check_list(items)
    )
    if (is.character(items)) {
      items <- purrr::map(items, ~ list(text = .x, label = ""))
    }
    purrr::walk(items, ~ checkmate::assert_subset(
      c("text", "label"), names(.x)
    ))
    checkmate::assert_subset(
      selected,
      purrr::map_chr(items, "text")
    )
    checkmate::assert_string(noResults)
    items <- unique(items)
    items <- purrr::map(items, function(item) {
      if (is.null(item$key)) {
        item$key <- paste0(item$text, "-", item$label)
      }
      item
    })
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(
        inputId = inputId,
        items = items,
        selected = selected,
        noResults = MenuItem(
          disabled = TRUE,
          text = noResults
        ),
        ...
      ),
      deps = blueprintDependency()
    )
  }
}

slider <- function(name) {
  function(inputId, values, min = NULL, max = NULL, ...) {
    checkmate::assert_string(inputId)
    checkmate::assert(
      checkmate::check_numeric(values),
      checkmate::check_list(values)
    )
    checkmate::check_number(min, null.ok = TRUE)
    checkmate::check_number(max, null.ok = TRUE)
    if (is.numeric(values)) {
      values <- purrr::map(values, ~ list(value = .x))
    }
    .values <- purrr::map_dbl(values, "value")
    if (!is.null(min)) {
      checkmate::assert_true(all(min < .values))
    } else {
      min <- base::min(.values)
    }
    if (!is.null(max)) {
      checkmate::assert_true(all(max > .values))
    } else {
      max <- base::max(.values)
    }
    shiny.react::reactElement(
      module = "@/shiny.blueprint",
      name = name,
      props = shiny.react::asProps(
        inputId = inputId,
        values = values,
        min = min,
        max = max,
        ...
      ),
      deps = blueprintDependency()
    )
  }
}

#' Breadcrumbs
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/breadcrumbs>
#'
#' @example inst/examples/Breadcrumbs.R
#' @inherit component params return
#' @export
Breadcrumbs <- component("Breadcrumbs")

#' Button
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/button>
#'
#' @example inst/examples/Button.R
#' @inherit component params return
#' @export
Button <- component("Button")

#' @rdname Button
#' @export
Button.shinyInput <- inputWithoutDefault("Button") # nolint

#' @rdname Button
#' @export
AnchorButton <- component("AnchorButton")

#' @rdname Button
#' @export
AnchorButton.shinyInput <- inputWithoutDefault("AnchorButton") # nolint

#' Button group
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/button-group>
#'
#' @example inst/examples/ButtonGroup.R
#' @inherit component params return
#' @export
ButtonGroup <- component("ButtonGroup")

#' Callout
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/callout>
#'
#' @example inst/examples/Callout.R
#' @inherit component params return
#' @export
Callout <- component("Callout")

#' Card
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/card>
#'
#' @example inst/examples/Card.R
#' @inherit component params return
#' @export
Card <- component("Card")

#' Collapse
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/collapse>
#'
#' @example inst/examples/Collapse.R
#' @inherit component params return
#' @export
Collapse <- component("Collapse")

#' Divider
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/divider>
#'
#' @example inst/examples/Divider.R
#' @inherit component params return
#' @export
Divider <- component("Divider")

#' Editable text
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/editable-text>
#'
#' @example inst/examples/EditableText.R
#' @inherit component params return
#' @export
EditableText <- component("EditableText")

#' @rdname EditableText
#' @export
EditableText.shinyInput <- input("EditableText", "") # nolint

#' HTML elements
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/html>
#'
#' @family HTML elements
#' @example inst/examples/htmlElements.R
#' @inherit component params return
#' @name htmlElements
NULL

#' @rdname htmlElements
#' @export
H1 <- component("H1")

#' @rdname htmlElements
#' @export
H2 <- component("H2")

#' @rdname htmlElements
#' @export
H3 <- component("H3")

#' @rdname htmlElements
#' @export
H4 <- component("H4")

#' @rdname htmlElements
#' @export
H5 <- component("H5")

#' @rdname htmlElements
#' @export
H6 <- component("H6")

#' @rdname htmlElements
#' @export
Blockquote <- component("Blockquote")

#' @rdname htmlElements
#' @export
Code <- component("Code")

# Label has its own documentation page.

#' @rdname htmlElements
#' @export
Pre <- component("Pre")

#' @rdname htmlElements
#' @export
OL <- component("OL")

#' @rdname htmlElements
#' @export
UL <- component("UL")

#' HTML table
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/html-table>
#'
#' @family HTML elements
#' @example inst/examples/HTMLTable.R
#' @inherit component params return
#' @export
HTMLTable <- component("HTMLTable")

# TODO: HotkeysTarget2

#' Icon
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/icon>
#'
#' A list of available icons: <https://blueprintjs.com/docs/#icons>
#' @example inst/examples/Icon.R
#' @inherit component params return
#' @export
Icon <- component("Icon")

#' Menu
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/menu>
#'
#' @example inst/examples/Menu.R
#' @inherit component params return
#' @export
Menu <- component("Menu")

#' @rdname Menu
#' @export
MenuItem <- component("MenuItem")

#' @rdname Menu
#' @export
MenuDivider <- component("MenuDivider")

#' Navbar
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/navbar>
#'
#' @example inst/examples/Navbar.R
#' @inherit component params return
#' @export
Navbar <- component("Navbar")

#' @rdname Navbar
#' @export
NavbarGroup <- component("NavbarGroup")

#' @rdname Navbar
#' @export
NavbarHeading <- component("NavbarHeading")

#' @rdname Navbar
#' @export
NavbarDivider <- component("NavbarDivider")

#' Non-ideal state
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/non-ideal-state>
#'
#' @example inst/examples/NonIdealState.R
#' @inherit component params return
#' @export
NonIdealState <- component("NonIdealState")

#' Overflow list
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/overflow-list>
#'
#' @example inst/examples/OverflowList.R
#' @inherit component params return
#' @export
OverflowList <- component("OverflowList")

#' Panel stack
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/panel-stack2>
#'
#' @example inst/examples/PanelStack.R
#' @inherit component params return
#' @export
PanelStack <- component("PanelStack2")

#' @rdname PanelStack
#' @param panels List of lists - each list contains `title` (string) and `content` (HTML)
#' @param ns Namespace of given panel stack (required if there's more than 1 panel stack)
#' @param size Numeric vector of length 2 - `c(width, height)`
#' @export
PanelStack.shinyWrapper <- function(panels, ns = "ps", size = c(300, 250), ...) { # nolint
  shiny.react::reactElement(
    module = "@/shiny.blueprint",
    name = "PanelStack",
    props = shiny.react::asProps(panels = panels, ns = ns, size = size, ...),
    deps = blueprintDependency()
  )
}

#' Progress bar
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/progress-bar>
#'
#' @example inst/examples/ProgressBar.R
#' @inherit component params return
#' @export
ProgressBar <- component("ProgressBar")

#' Resize sensor
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/resize-sensor>
#'
#' @example inst/examples/ResizeSensor.R
#' @inherit component params return
#' @export
ResizeSensor <- component("ResizeSensor")

#' @rdname ResizeSensor
#' @export
ResizeSensor.shinyInput <- inputWithoutDefault("ResizeSensor") # nolint

#' Spinner
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/spinner>
#'
#' @example inst/examples/Spinner.R
#' @inherit component params return
#' @export
Spinner <- component("Spinner")

#' Tabs
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/tabs>
#'
#' @example inst/examples/Tabs.R
#' @inherit component params return
#' @export
Tabs <- component("Tabs")

#' @rdname Tabs
#' @export
Tab <- component("Tab")

#' @rdname Tabs
#' @export
TabsExpander <- component("Expander")

#' Tag
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/tag>
#'
#' @example inst/examples/Tag.R
#' @inherit component params return
#' @export
Tag <- component("Tag")

#' Text
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/text>
#'
#' @example inst/examples/Text.R
#' @inherit component params return
#' @export
Text <- component("Text")

#' Tree
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/tree>
#'
#' @example inst/examples/Tree.R
#' @inherit component params return
#' @param data A list of nodes parameters:
#' \itemize{
#'   \item required: `label`
#'   \item optional: `childNodes`, `icon`, `hasCaret`, `isExpanded`, `disabled`, `secondaryLabel`
#' }
#' @export
Tree <- component("Tree")

#' @rdname Tree
#' @export
Tree.shinyInput <- tree("Tree") # nolint

#' Form group
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/form-group>
#'
#' @example inst/examples/FormGroup.R
#' @inherit component params return
#' @export
FormGroup <- component("FormGroup")

#' Control group
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/control-group>
#'
#' @example inst/examples/ControlGroup.R
#' @inherit component params return
#' @export
ControlGroup <- component("ControlGroup")

#' Label
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/label>
#'
#' @family HTML elements
#' @example inst/examples/Label.R
#' @inherit component params return
#' @export
Label <- component("Label")

#' Checkbox
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/checkbox>
#'
#' @example inst/examples/Checkbox.R
#' @inherit component params return
#' @export
Checkbox <- component("Checkbox")

#' @rdname Checkbox
#' @export
Checkbox.shinyInput <- input("Checkbox", FALSE) # nolint

#' Radio
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/radio>
#'
#' @example inst/examples/Radio.R
#' @inherit component params return
#' @export
Radio <- component("Radio")

#' @rdname Radio
#' @export
RadioGroup <- component("RadioGroup")

#' @rdname Radio
#' @export
RadioGroup.shinyInput <- input("RadioGroup", NULL) # nolint

#' HTML select
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/html-select>
#'
#' @example inst/examples/HTMLSelect.R
#' @inherit component params return
#' @export
HTMLSelect <- component("HTMLSelect")

#' @rdname HTMLSelect
#' @export
HTMLSelect.shinyInput <- input("HTMLSelect", "") # nolint

#' Slider
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/sliders.slider>
#'
#' @example inst/examples/Slider.R
#' @inherit component params return
#' @export
Slider <- component("Slider")

#' @rdname Slider
#' @export
Slider.shinyInput <- input("Slider", 0) # nolint

#' Range slider
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/sliders.range-slider>
#'
#' @example inst/examples/Slider.R
#' @inherit component params return
#' @export
RangeSlider <- component("RangeSlider")

#' @rdname RangeSlider
#' @export
RangeSlider.shinyInput <- input("RangeSlider", c(0, 0)) # nolint

#' Multi slider
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/sliders.multi-slider>
#'
#' @example inst/examples/MultiSlider.R
#' @inherit component params return
#' @param values Numeric vector or list containing `value` and other params passed
#'   to `MultiSliderHandle`
#' @param min Minimal value of the slider
#' @param max Maximum value of the slider
#' @export
MultiSlider <- component("MultiSlider")

#' @rdname MultiSlider
#' @export
MultiSlider.shinyInput <- slider("MultiSlider") # nolint

#' @rdname MultiSlider
#' @export
MultiSliderHandle <- properties("MultiSliderHandle")

#' Switch
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/switch>
#'
#' @example inst/examples/Switch.R
#' @inherit component params return
#' @export
Switch <- component("Switch")

#' @rdname Switch
#' @export
Switch.shinyInput <- input("Switch", FALSE) # nolint

#' FileInput
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/file-input>
#'
#' @example inst/examples/Switch.R
#' @inherit component params return
#' @export
FileInput <- component("FileInput")

#' @rdname FileInput
#' @export
FileInput.shinyInput <- input("FileInput", "") # nolint

#' NumericInput
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/numeric-input>
#'
#' @example inst/examples/NumericInput.R
#' @inherit component params return
#' @export
NumericInput <- component("NumericInput")

#' @rdname NumericInput
#' @export
NumericInput.shinyInput <- input("NumericInput", 0) # nolint

#' Input group
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/text-inputs.input-group>
#'
#' @example inst/examples/InputGroup.R
#' @inherit component params return
#' @export
InputGroup <- component("InputGroup")

#' @rdname InputGroup
#' @export
InputGroup.shinyInput <- input("InputGroup", "") # nolint

#' TagInput
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/tag-input>
#'
#' @example inst/examples/TagInput.R
#' @inherit component params return
#' @export
TagInput <- component("TagInput")

#' @rdname TagInput
#' @export
TagInput.shinyInput <- input("TagInput", NULL) # nolint

#' Text area
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/text-inputs.text-area>
#'
#' @example inst/examples/TextArea.R
#' @inherit component params return
#' @export
TextArea <- component("TextArea")

#' @rdname InputGroup
#' @export
TextArea.shinyInput <- input("TextArea", "") # nolint

#' Overlay
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/overlay>
#'
#' @example inst/examples/Overlay.R
#' @inherit component params return
#' @export
Overlay <- component("Overlay")

# TODO: Portal

#' Alert
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/alert>
#'
#' @example inst/examples/Alert.R
#' @inherit component params return
#' @export
Alert <- component("Alert")

# TODO: Context menu

#' Dialog
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/dialog.dialog>
#'
#' @example inst/examples/Dialog.R
#' @inherit component params return
#' @export
Dialog <- component("Dialog")

#' Multistep dialog
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/dialog.multistep-dialog>
#'
#' @example inst/examples/MultistepDialog.R
#' @inherit component params return
#' @export
MultistepDialog <- component("MultistepDialog")

#' @rdname MultistepDialog
#' @export
DialogStep <- component("DialogStep")

#' Drawer
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/drawer>
#'
#' @example inst/examples/Drawer.R
#' @inherit component params return
#' @export
Drawer <- component("Drawer")

#' Popover
#'
#' Documentation: <https://blueprintjs.com/docs/#core/components/popover>
#'
#' @example inst/examples/Popover.R
#' @inherit component params return
#' @export
Popover <- component("Popover")

#' Select
#'
#' Documentation: <https://blueprintjs.com/docs/#select/select2>
#'
#' @example inst/examples/Select.R
#' @inherit component params return
#' @param items A list of options (character vector or list containing `text` and `label` entries)
#' @param selected Initialy selected item
#' @param noResults Message when no results were found
#' @export
Select <- component("Select")

#' @rdname Select
#' @export
Select.shinyInput <- select("Select") # nolint

#' Suggest
#'
#' Documentation: <https://blueprintjs.com/docs/#select/suggest2>
#'
#' @example inst/examples/Suggest.R
#' @inherit component params return
#' @param items A list of options (character vector or list containing `text` and `label` entries)
#' @param selected Initialy selected item
#' @param noResults Message when no results were found
#' @export
Suggest <- component("Suggest")

#' @rdname Suggest
#' @export
Suggest.shinyInput <- select("Suggest") # nolint

#' MultiSelect
#'
#' Documentation: <https://blueprintjs.com/docs/#select/multi-select2>
#'
#' @example inst/examples/MultiSelect.R
#' @inherit component params return
#' @param items A list of options (character vector or list containing `text` and `label` entries)
#' @param selected Initialy selected item
#' @param noResults Message when no results were found
#' @export
MultiSelect <- component("MultiSelect")

#' @rdname MultiSelect
#' @export
MultiSelect.shinyInput <- select("MultiSelect") # nolint


# TODO: Tooltip

# TODO: HotkeysProvider
