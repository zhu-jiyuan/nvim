local M = {}

-- Border of the completion, hover and diagnostic floats; M.border picks a style. "ruled" draws only the sides,
-- as 1/8-cell blocks on the outer cell edges, and leaves the top and bottom to the float's fill: a top or bottom
-- border takes a whole row, which shows as a blank line next to the content.
M.borders = {
	rounded = "rounded",
	ruled = { "", "", "", "▕", "", "", "", "▏" },
}
M.border = "rounded"

return M
