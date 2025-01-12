#!/bin/zsh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Help menu function
function dev_help() {
    echo "${BLUE}📚 Development Commands Help Menu${NC}"
    echo "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "${CYAN}i${NC}        - Install dependencies"
    echo "${CYAN}d${NC}        - Start development server"
    echo "${CYAN}b${NC}        - Build project"
    echo "${CYAN}start${NC}    - Start production server"
    echo "${CYAN}rmall${NC}    - Remove all dependencies and build files"
    echo "${CYAN}restart${NC}  - Clean, reinstall, and start dev server"
    echo "${CYAN}rebuild${NC}  - Clean, reinstall, and build project"
    echo "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "Use ${GREEN}dev_help${NC} to show this menu again"
}

# Show help menu on first source
alias devhelp=dev_help

# Install dependencies
function i() {
    echo "${BLUE}📦 Installing dependencies...${NC}"
    pnpm install
    if [ $? -eq 0 ]; then
        echo "${GREEN}✅ Dependencies installed successfully!${NC}"
    else
        echo "${RED}❌ Failed to install dependencies${NC}"
    fi
}

# Start development server
function d() {
    echo "${CYAN}🚀 Starting development server...${NC}"
    pnpm dev
}

# Build project
function b() {
    echo "${PURPLE}🏗️  Building project...${NC}"
    pnpm build
    if [ $? -eq 0 ]; then
        echo "${GREEN}✅ Build completed successfully!${NC}"
    else
        echo "${RED}❌ Build failed${NC}"
    fi
}

# Start production server
function start() {
    echo "${CYAN}🚀 Starting production server...${NC}"
    pnpm start
}

# Remove all dependencies and build files
function rmall() {
    echo "${YELLOW}🗑️  Cleaning project...${NC}"
    echo "${YELLOW}📁 Removing node_modules...${NC}"
    rm -rf node_modules
    echo "${YELLOW}📁 Removing .next directory...${NC}"
    rm -rf .next
    echo "${GREEN}✨ Clean completed!${NC}"
}

# Restart development environment
function restart() {
    echo "${PURPLE}🔄 Restarting development environment...${NC}"
    rmall
    echo "${BLUE}📦 Reinstalling dependencies...${NC}"
    pnpm install
    if [ $? -eq 0 ]; then
        echo "${GREEN}✅ Dependencies reinstalled successfully!${NC}"
        echo "${CYAN}🚀 Starting development server...${NC}"
        pnpm dev
    else
        echo "${RED}❌ Failed to reinstall dependencies${NC}"
    fi
}

# Rebuild project
function rebuild() {
    echo "${PURPLE}🔄 Rebuilding project from scratch...${NC}"
    rmall
    echo "${BLUE}📦 Reinstalling dependencies...${NC}"
    pnpm install
    if [ $? -eq 0 ]; then
        echo "${GREEN}✅ Dependencies reinstalled successfully!${NC}"
        echo "${PURPLE}🏗️  Building project...${NC}"
        pnpm build
        if [ $? -eq 0 ]; then
            echo "${GREEN}✅ Rebuild completed successfully!${NC}"
        else
            echo "${RED}❌ Build failed${NC}"
        fi
    else
        echo "${RED}❌ Failed to reinstall dependencies${NC}"
    fi
} 
