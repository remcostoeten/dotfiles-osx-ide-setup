# Helper menu function
function show_help() {
    echo -e "${BLUE}---------------------------------------------${NC}"
    echo -e "${BLUE} Main Injector Script Help Menu ${NC}"
    echo -e "${BLUE}---------------------------------------------${NC}"
    echo -e "${GREEN}This script sources all .sh files in the current directory, injectors directory, and utilities directory.${NC}"
    echo -e "${GREEN}Usage:${NC}"
    echo -e "${GREEN}  ./main_injector.sh${NC}"
    echo -e "${GREEN}Example of colors.sh utility:${NC}"
    echo -e "${YELLOW}  # colors.sh provides color codes for terminal output${NC}"
    echo -e "${YELLOW}  # Usage example:${NC}"
    echo -e "${YELLOW}  echo -e \"\${RED}This is red text\${NC}\"${NC}"
    echo -e "${YELLOW}  echo -e \"\${GREEN}This is green text\${NC}\"${NC}"
    echo -e "${YELLOW}  echo -e \"\${BLUE}This is blue text\${NC}\"${NC}"
    echo -e "${BLUE}---------------------------------------------${NC}"
}
