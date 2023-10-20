return {
    --styles--
    style = {
        reset = '\27[0m';
        bold = '\27[1m';
        italic = '\27[3m';
        underline = '\27[4m';
        inverse = '\27[7m'
    };
    --colors--
    color = {
        --fg--
        fg = {
            --normal--
            normal = {
                black = '\27[30m';
                red = '\27[31m';
                green = '\27[32m';
                yellow = '\27[33m';
                blue = '\27[34m';
                magenta = '\27[35m';
                cyan = '\27[36m';
                white = '\27[37m';
            };
            --bright--
            bright = {
                red = '\27[91m';
                green = '\27[92m';
                yellow = '\27[93m';
                blue = '\27[94m';
                magenta = '\27[95m';
                cyan = '\27[96m';
                white = '\27[97m';
            }
        };
        --bg--
        bg = {
            --normal--
            normal = {
                black = '\27[40m';
                red = '\27[41m';
                green = '\27[42m';
                yellow = '\27[43m';
                blue = '\27[44m';
                magenta = '\27[45m';
                cyan = '\27[46m';
                white = '\27[47m'
            };
            --bight--
            bright = {
                black = '\27[100m';
                red = '\27[101m';
                green = '\27[102m';
                yellow = '\27[103m';
                blue = '\27[104m';
                magenta = '\27[105m';
                cyan = '\27[106m';
                white = '\27[107m';
            }
        }
    };
    patterns = {
        danger = '\27[1;91m';
        boldItalic = '\27[1;3m'
    }
}