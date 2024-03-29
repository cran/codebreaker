#' Print sprite in console
#'
#' @param txt Text string containing sprite definition
#' @import cli
#' @return Prints sprite in console 

sprite_show <- function(txt)  {
  for (i in seq_len(nchar(txt))) {
    char <- substr(txt, i, i)
    if(char == "R") {cat(bg_red(" "))}
    if(char == "B") {cat(bg_blue(" "))}
    if(char == "C") {cat(bg_cyan(" "))}
    if(char == "G") {cat(bg_green(" "))}
    if(char == "M") {cat(bg_magenta(" "))}
    if(char == "Y") {cat(bg_yellow(" "))}
    if(char == "W") {cat(bg_white(" "))}
    if(char == "X") {cat(bg_black(" "))}
    if(char == ".") {cat(" ")}
    if(!char %in% c("R","B","C","G","M","Y","W","Y","W","X",".")) {cat(char)}
  }   
} # sprite_show() 


#' Show Code Breaker Intro 
#'
#' @param name Player name
#' @return Prints sprite in console 

cb_intro <- function(name = NULL) {
  
  sprite1 <- paste0(
    ".......YYYY..YYYY..YYYYY..YYYYY.", "\n",
    "......YY....YY..YY.YY..YY.YY....", "\n",
    "......YY....YY..YY.YY  YY.YYYY..", "\n",
    "......YY... YY..YY.YY..YY.YY....", "\n",
    ".......YYYY..YYYY..YYYYY..YYYYY.")
  
  sprite2 <- paste0(
    "BBBB..CCCC.CCCC..CC..C..C.CCCC.RRRR..","\n",
    "B .BB.C..C.C....C..C.C.C..C....R..R..","\n",
    "BBBB..CCCC.CCC..CCCC.CC...CCC..RRRR..","\n",
    "B .BB.C.C..C....C..C.C.C..C....R.R...","\n",
    "BBBB..C..C.CCCC.C..C.C..C.CCCC.R..R..","\n")
  
  cat("\n")
  sprite_show(sprite1)
  cat("\n  Master Logic to Break the Code!\n")
  sprite_show(sprite2)
  cat("\n")
  cat("\n")
  
} # cb_intro()


#' Show Code Breaker Success 
#'
#' @param name Player name
#' @return Prints sprite in console 

cb_success <- function(name = NULL) {
  
  txt <- paste0(
    "..............YYYY.", "\n",
    ".............YY..YY", "\n",
    "...YYYYYYYYYYYY..YY", "\n",
    "...Y.Y.......YY..YY", "\n",
    "...Y.Y........YYYY.", "\n")
  
  cat("\n\n")
  sprite_show(txt)
  cat("   C o n g r a t s!")
  cat("\n")
  cat("\n")
  
} # cb_success()


#' Show Code Breaker Race Cup 
#'
#' @param name Player name
#' @return Prints sprite in console 

cb_race_cup <- function(name = NULL) {
  
  txt <- paste0(
    "....YYYYYYYYYYY....", "\n",
    ".....YYYYYYYYY.....", "\n",
    "......YYYYYYY......", "\n",
    ".......YYYYY.......", "\n",
    "........YYY........", "\n",
    ".........Y.........", "\n",
    ".........Y.........", "\n",
    ".......YYYYY.......", "\n")
  
  cat("\n\n")
  sprite_show(txt)
  cat("  Your Race Cup!")
  cat("\n")
  cat("\n")
  
} # cb_race_cup()


#' Show color in console 
#'
#' @param color Color
#' @import cli
#' @return Prints color in console 

cb_show_color <- function(color)  {

  if (color == "R") { cat(bg_red(" R ")) }
  if (color == "B") { cat(bg_blue(" B ")) }
  if (color == "G") { cat(bg_green(" G ")) }
  if (color == "Y") { cat(bg_yellow(" Y ")) }
  if (color == "M") { cat(bg_magenta(" M ")) }
  if (color == "X") { cat(" X ") }
  
} # cb_show_color()


#' Selct Colors 
#'
#' @param colors Selected colors
#' @param empty Empty code digit in secret code allowed?
#' @param name Player name
#' @return Print selected colors in console 

cb_select_colors <- function(colors = NA, empty = FALSE, name = NULL) {

  # input colors
  if (is.na(colors)) {
    colors <- readline(prompt = "How many colors (2-5) ? ")
  }
  
  colors <- suppressWarnings(as.integer(colors))
  
  if (is.na(colors) | colors < 2 | colors > 5) {
    cat("Selected default (2 colors)")
    colors <- 2
  }
  
  color_list <- NULL
  
  
  # show available colors
  cat("\n")
  cat("Colors: ")
  if (colors >= 2) {
    cat(bg_blue(" B "))
    cat("lue ")
    color_list <- c(color_list, "B")
  }
  if (colors >= 1) {
    cat(bg_red(" R "))
    cat("ed ")
    color_list <- c(color_list, "R")
  }
  if (colors >= 3) {
    cat(bg_green(" G "))
    cat("reen ")
    color_list <- c(color_list, "G")
  }
  if (colors >= 4) {
    cat(bg_yellow(" Y "))
    cat("ellow ")
    color_list <- c(color_list, "Y")
  }
  if (colors >= 5) {
    cat(bg_magenta(" M "))
    cat("agenta ")
    color_list <- c(color_list, "M")
  }
  if (empty) {
    cat(bg_black(" X "))
    cat("")
  }

  # return values
  color_count <- colors
  color_chars <- paste(color_list, collapse = "")

  # add X if empty == TRUE
  if (empty) {
    color_count <- color_count + 1
    color_chars <- paste0(color_chars, "X")
    color_list <- c(color_list, "X")
  }
    
  # return
  return(list(color_count = color_count, 
              color_chars = color_chars, 
              color_list = color_list))  
}


#' Convert code into a vector
#'
#' @param code Code
#' @return vector 

cb_code2vector <- function(code) {
  
  code_vector <- strsplit(code, split="",fixed = TRUE)[[1]]

  return(code_vector)
  
} # cb_code2vector()


#' Check code if correct 
#'
#' @param code_check Code to check
#' @param code_secret Secret code
#' @return list  

cb_check_code <- function(code_check, code_secret)  {

  # code empty?
  if (nchar(code_check) == 0) {
    return(list(all = 0, color = 0))
  }
    
  # check for correct position + color
  pattern_check <- cb_code2vector(code_check)
  pattern_secret <- cb_code2vector(code_secret)
  
  check_correct <- 0
  for (i in 1:nchar(code_check))  {
    char_check <- substr(code_check,i,i)
    char_secret <- substr(code_secret,i,i)
    
    if (char_check != "X" & char_check == char_secret ) {
      pattern_check[i] <- "."
      pattern_secret[i] <- "."
      check_correct <- check_correct + 1
    }
  }
  
  # check for correct color
  
  check_color <- 0
  
  for (i in 1:length(pattern_check))  {
    
    char <- pattern_check[i]
    #cat(char, ": ")
    
    if (char != "." & char != "X") {
      
      color_match <- match(char, pattern_secret)
      #cat(pattern_check, " | ", pattern_secret, " | ")
      #cat(color_match)
      #cat("\n")
      
      if (!is.na(color_match[1])) {
        check_color <- check_color + 1
        pattern_check[i] <- "."
        pattern_secret[color_match[1]] <- "."
        
      } # if
      
    } # if
    
  } # for
      
  return(list(all = check_correct, color = check_color))
}

#' Clean code 
#'
#' @param code Code
#' @param code_length Length of code
#' @return clean code  

cb_clean_code <- function(code, code_length = 4)  {

  # convert into string (if necessary)
  if (is.vector(code)) {
    code <- paste(code, collapse = "")
  }

  # Upper Case
  code <- toupper(code)
  
  # check if empty
  if (code == "") {
    code <- "XXXX"
  }

  # check if EXIT
  if (code == "EXIT")  {
    return("EXIT")
  }
  
  # clean code
  code_clean <- ""
  for (i in 1:nchar(code)) {
    char <- substr(code, i, i)
    if (char %in% c("R","B","G","Y","M","X")) {
      code_clean <- paste0(code_clean, char) 
    }
  }  

  # add X
  code_clean <- paste0(code_clean, 
                       paste(rep("X", code_length), collapse = ""))
                                         
  # limit length to code_length                                       
  code_clean <- substr(code_clean, 1, code_length)
  
  return(code_clean)
}

#' Show code in console 
#'
#' @param code Code
#' @return Console output  

cb_show_code <- function(code) {
  
  if (is.vector(code)) {
    code <- paste(code, collapse = "")
  }
  
  for (i in 1:nchar(code)) {
    char <- substr(code, i, i)
    if (char %in% c("R","B","G","Y","M","X")) {
      cb_show_color(char)
      cat(" ")
    }
  }  
  
} 

#' Input code 
#'
#' @param step Step
#' @param code_length Length of code
#' @param color_list List of available colors
#' @import cli
#' @return code  

cb_input_code <- function(step = 1, code_length = 4, color_list = c("R", "B"))  {

  # prompt
  prompt <- paste0("Your code (you can use ",
                   paste(color_list, collapse=" "))
  
  if ("X" %in% color_list) {
    prompt <- paste0(prompt, ") : ")
  } else {
    prompt <- paste0(prompt, " X) : ")
  }
          
  # input code          
  code <- readline(prompt = prompt)
  code <- cb_clean_code(code, code_length)
  
  # check for EXIT
  if (code != "EXIT") {
  
    cat(col_silver("Try"), ifelse(step<10, paste0("0",step),step))
    cat(col_silver(": "))
    cb_show_code(code)

  } # if
  
  # return code
  return(code)
  
}

#' Play a code breaker game 
#'
#' @param colors Colors that can be used in game
#' @param empty Empty code digit in secret code allowed?
#' @param sound Play sounds?
#' @param name Player name
#' @return list

cb_play_game <- function(colors = NA, empty = FALSE, sound = TRUE, name = NULL) {

  # select colors
  setup <- cb_select_colors(colors, empty)

  # info
  cat("\n")
  cat("The code consists of 4 letters/colors (e.g. B R R B)\n")
  if (empty) {cat("Digits of the code may be empty (X)\n")}
  cat("Try to break it! (Enter exit to stop)\n")
  
  # codemaker
  secret_code <- sample(setup$color_list, 4, replace = TRUE)
  secret_code <- paste(secret_code, collapse = "") 

  # secret code must contain at least 1 color
  if (secret_code == "XXXX") {secret_code <- "XXXB"}
  
  try = 1
  game_over <- FALSE
  game_success <- FALSE
  
  while(!game_over) {
    
    code <- cb_input_code(try, 4, setup$color_list)
    
    if (code == "EXIT") {
      cat("\n")
      cat("Game stopped!")
      game_success <- FALSE
      break
    }
    
    # check if correct
    correct <- cb_check_code(code, secret_code)
    cat(col_silver("correct:"), correct$all)
    cat(col_silver(" (color only:"),correct$color)
    cat(col_silver(")"))
    if (sound) {beepr::beep("ping")}
 
    # success?
    if (code == secret_code) {
      game_over <- TRUE
      game_success <- TRUE
      cb_success()
      if (sound) {beepr::beep("mario")}
    } else {
      try <- try + 1
    }
    
  } # while
  
  return(list(try = try, game_success = game_success))
  
} # cp_play_game()

#' Play codebreaker game 
#'
#' @param sound Play sounds?
#' @param name Name of player
#' @return list  
#' @export
#' @examples
#' ## Start game (in interactive R sessions)
#' if (interactive())  {
#'    codebreaker()
#' }
codebreaker <- function(sound = TRUE, name = NULL)  {

  cb_intro()
  if (sound) {beepr::beep("fanfare")}
 
  game_mode <- readline(prompt = "(S)ingle game, (R)ace or (X)treme ? ")
  game_mode <- toupper(game_mode)
  
  if (game_mode == "S") {game_mode <- "single"}
  if (game_mode == "R") {game_mode <- "race"}
  if (game_mode == "X") {game_mode <- "xtreme"}
  
  if (!game_mode %in% c("single", "race", "xtreme")) {
    game_mode <- "single"
  }

  if (game_mode == "single") {    

    result <- cb_play_game(colors = NA, sound = sound, name = name)
    
  } else {
  
    # empty for codemaker allowed?
    if (game_mode == "xtreme") {
      empty <- TRUE
    } else {
      empty <- FALSE
    }  
    
    # start settings
    stage <- 1
    try_total <- 0
    colors_start <- 2
    colors_end <- 5
    game_stop <- FALSE
 
    # game loop
    for (i in colors_start:colors_end) {
      
      cat("\n")
      cat(bg_cyan(paste("Race: Round", stage, "->", i, "colors          ")))
      cat("\n")
      
      result <- cb_play_game(colors = i, empty <- empty, sound = sound, name = name)
      if (result$game_success == FALSE) {
        game_stop <- TRUE
        break
        }
      try_total <- try_total + result$try
      stage <- stage + 1
      
      Sys.sleep(2)
      
      if (i < colors_end)  {
        cat("Get ready for the next code!")
        cat("\n")
      }
    } # for

    if (!game_stop)  {
      cat("You mastered the race!\n")
      Sys.sleep(2)
      cat("Total Try:", try_total,"\n")
      
      Sys.sleep(2)
      cb_race_cup()
      beepr::beep("treasure")
      
    } # if !game_stop
    
  } # if single/race

} # codebreaker()
