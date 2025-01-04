-- Tetris in LÖVE 2D

-- Initialize game variables
local grid = {}
local gridWidth, gridHeight = 10, 20
local cellSize = 30
local tetrominoes = {}
local currentPiece = nil
local nextPiece = nil
local gameOver = false
local dropTimer = 0
local dropInterval = 0.5 -- Control speed of falling pieces

-- Colors for tetrominoes
local colors = {
    {1, 0, 0},    -- Red
    {0, 1, 0},    -- Green
    {0, 0, 1},    -- Blue
    {1, 1, 0},    -- Yellow
}

-- Tetromino shapes
local shapes = {
    {{1, 1, 1}, {0, 1, 0}},     -- T-shape
    {{1, 1}, {1, 1}},           -- O-shape
    {{1, 0, 0}, {1, 1, 1}},     -- L-shape
    {{0, 0, 1}, {1, 1, 1}},     -- J-shape
}

-- Initialize grid
local function initializeGrid()
    for y = 1, gridHeight do
        grid[y] = {}
        for x = 1, gridWidth do
            grid[y][x] = 0
        end
    end
end

local function rotatePiece(piece)
    local newShape = {}
    for y = 1, #piece.shape[1] do
        newShape[y] = {}
        for x = 1, #piece.shape do
            newShape[y][x] = piece.shape[#piece.shape - x + 1][y]
        end
    end
    return newShape
end

-- Spawn a new tetromino
local function spawnTetromino()
    local shapeIndex = love.math.random(1, #shapes)
    local shape = shapes[shapeIndex]
    currentPiece = {
        shape = shape,
        x = math.floor(gridWidth / 2) - math.floor(#shape[1] / 2),
        y = 1,
        color = colors[shapeIndex],
    }
end

-- Draw the grid and pieces
local function drawGrid()
    for y = 1, gridHeight do
        for x = 1, gridWidth do
            if grid[y][x] ~= 0 then
                love.graphics.setColor(grid[y][x])
                love.graphics.rectangle("fill", (x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize)
            end
        end
    end
end

local function drawTetromino(piece)
    if not piece then return end
    love.graphics.setColor(piece.color)
    for row = 1, #piece.shape do
        for col = 1, #piece.shape[row] do
            if piece.shape[row][col] ~= 0 then
                love.graphics.rectangle(
                    "fill",
                    (piece.x + col - 2) * cellSize,
                    (piece.y + row - 2) * cellSize,
                    cellSize,
                    cellSize
                )
            end
        end
    end
end

-- Check collision
local function checkCollision(piece, offsetX, offsetY)
    for row = 1, #piece.shape do
        for col = 1, #piece.shape[row] do
            if piece.shape[row][col] ~= 0 then
                local newX = piece.x + col - 1 + offsetX
                local newY = piece.y + row - 1 + offsetY
                if newX < 1 or newX > gridWidth or newY > gridHeight or (grid[newY] and grid[newY][newX] ~= 0) then
                    return true
                end
            end
        end
    end
    return false
end

-- Lock tetromino in grid
local function lockTetromino(piece)
    for row = 1, #piece.shape do
        for col = 1, #piece.shape[row] do
            if piece.shape[row][col] ~= 0 then
                local gridX = piece.x + col - 1
                local gridY = piece.y + row - 1
                grid[gridY][gridX] = piece.color
            end
        end
    end
    sounds.drop:play()
end

local clearAnimation = {}
-- Clear full lines
local function clearLines()
    for y = gridHeight, 1, -1 do
        local full = true
        for x = 1, gridWidth do
            if grid[y][x] == 0 then
                full = false
                break
            end
        end
        if full then
            table.insert(clearAnimation, y)
            table.remove(grid, y)
            table.insert(grid, 1, {})
            for x = 1, gridWidth do
                grid[1][x] = 0
            end
            sounds.clear:play()
        end
    end
end

-- Update game state
local function updateGame(dt)
    dropTimer = dropTimer + dt
    if dropTimer >= dropInterval then
        dropTimer = 0
        if not currentPiece then
            spawnTetromino()
        else
            if not checkCollision(currentPiece, 0, 1) then
                currentPiece.y = currentPiece.y + 1
            else
                lockTetromino(currentPiece)
                clearLines()
                currentPiece = nil
            end
        end
    end
end

-- Handle player input
local function handleInput(key)
    if not currentPiece then return end

    if key == "left" and not checkCollision(currentPiece, -1, 0) then
        currentPiece.x = currentPiece.x - 1
        sounds.move:play()
    elseif key == "right" and not checkCollision(currentPiece, 1, 0) then
        currentPiece.x = currentPiece.x + 1
        sounds.move:play()
    elseif key == "down" and not checkCollision(currentPiece, 0, 1) then
        currentPiece.y = currentPiece.y + 1
        sounds.move:play()
    elseif key == "up" then
        local rotatedShape = rotatePiece(currentPiece)
        if not checkCollision({shape = rotatedShape, x = currentPiece.x, y = currentPiece.y}, 0, 0) then
            currentPiece.shape = rotatedShape
            sounds.rotate:play()
        end
    end
end

local function saveGame()
    local saveData = {
        grid = grid,
        currentPiece = currentPiece,
        nextPiece = nextPiece,
        gameOver = gameOver,
    }
    love.filesystem.write("savegame.lua", table.show(saveData, "saveData"))
end

local function loadGame()
    if love.filesystem.getInfo("savegame.lua") then
        local chunk = love.filesystem.load("savegame.lua")
        chunk()
        grid = saveData.grid
        currentPiece = saveData.currentPiece
        nextPiece = saveData.nextPiece
        gameOver = saveData.gameOver
    end
end

local sounds = {
    rotate = love.audio.newSource("rotate.mp3", "static"),
    move = love.audio.newSource("move.mp3", "static"),
    drop = love.audio.newSource("drop.mp3", "static"),
    clear = love.audio.newSource("clear.mp3", "static"),
}

function love.load()
    love.window.setMode(gridWidth * cellSize, gridHeight * cellSize)
    initializeGrid()
end

function love.update(dt)
    if not gameOver then
        updateGame(dt)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "s" then
        saveGame()
    elseif key == "l" then
        loadGame()
    elseif not gameOver then
        handleInput(key)
    end
end

local function drawClearAnimation()
    for _, y in ipairs(clearAnimation) do
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle("fill", 0, (y - 1) * cellSize, gridWidth * cellSize, cellSize)
    end
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    drawGrid()
    drawTetromino(currentPiece)
    drawClearAnimation()
end
