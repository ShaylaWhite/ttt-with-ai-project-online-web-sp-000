class CLI
    attr_accessor:game_mode, :token
    
    def greeting
        puts ""
        puts "Welcome to Tic Tac Toe!"
        puts "Enter 1 to play against another human."
        puts "Enter 2 to play against the computer."
        puts "Enter 3 or wargames to pit two computer players against each other."
        puts "Enter exit to quit."
    end
    
    def get_mode
        @game_mode = gets.strip
    end
    
    def get_token
        @token = gets.strip.upcase
    end
    
    def validate_mode
        while !@game_mode.to_i.between?(1, 3) && @game_mode != "wargames" && @game_mode != "exit"
            puts "I don't recognize that. Please enter 1, 2, 3, or wargames."
            get_mode
        end
    end
    
    def human_vs_human
        puts "X goes first! Are you ready?"
        game = Game.new(Players::Human.new("X"), Players::Human.new("O"), Board.new)
        game.play
    end
    
    def human_vs_ai
        puts "X or O?"
        get_token
        
        while @token != "X" && @token != "O"
            puts "I don't recognize that. X or O?"
            get_token
        end
        
        game = nil
        if @token == "X" 
            game = Game.new(Players::Human.new("X"), Players::Computer.new("O"), Board.new)
        else
            game = Game.new(Players::Computer.new("X"), Players::Human.new("O"), Board.new)
        end
        game.play
    end
    
    def ai_vs_ai
        puts "Get ready to watch the battle unfold!"
        puts ""
        sleep 1.5
        game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new)
        game.play
    end
    
    def wargames
        won_count = 0
        100.times do
            game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new)
            outcome = game.play
            if outcome != nil
                won_count += 1
            end
        end
        puts ""
        puts "Wargames complete!"
        puts "#{won_count} out of 100 games had a winner."
    end
    
    def call
        while @game_mode != "exit"
            greeting
            get_mode
            validate_mode
    
            case
                when @game_mode == "1"
                    human_vs_human
                when @game_mode == "2"
                    human_vs_ai
                when @game_mode == "3"
                    ai_vs_ai
                when @game_mode == "wargames"
                    wargames
            end
        end
        puts "See you next time!"
    end
end