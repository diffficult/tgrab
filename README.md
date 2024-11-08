# 📋 tgrab

A simple yet powerful script to grab and copy to clipboard the output of previously executed commands in your tmux session. Perfect for when you need to capture that command output you forgot to redirect to a file!

## 🚀 Features

- Copy the last command's output to clipboard
- Select specific previous command outputs (e.g., 2nd to last, 3rd to last, etc.)
- Nice visual feedback with nerd font icons
- Error handling with visually distinct messages
- Automatic detection of missing dependencies

## 📋 Requirements

- tmux
- xclip (for clipboard operations)
- zsh
- A terminal with [Nerd Fonts](https://www.nerdfonts.com/) installed for the icons

## 📥 Installation

1. Clone this repository:
```bash
git clone https://github.com/diffficult/tgrab.git
cd tgrab
```

2. Make it executable:
```bash
chmod +x tgrab
```

3. Move it to your local bin:
```bash
mv tgrab ~/.local/bin/
```

Make sure `~/.local/bin` is in your PATH. If it's not, add this line to your `~/.zshrc`:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

## 🔧 Usage

The script can be used in two ways:

1. Copy the last command's output:
```bash
tgrab
```

2. Copy a specific previous command's output using the `-p` flag:
```bash
tgrab -p 3  # Copies the 3rd to last command output
```

### Options

- `-p NUMBER`: Specify which previous output to copy (default: 1)
- `-h`: Show help message

## 📝 Examples

```bash
# Copy the last command's output
tgrab

# Copy the output from 3 commands ago
tgrab -p 3

# Show help
tgrab -h
```

## ⚠️ Error Handling

The script includes several error checks:
- Verifies xclip is installed
- Checks if there are enough previous outputs in buffer
- Validates if there's actually content to copy
- Ensures numeric input for the -p option

All errors are displayed with distinct red-on-white formatting and helpful icons.

## 🔍 Known Limitations

- Works only within tmux sessions
- Requires zsh as the shell
- Designed for prompts using the ❯❯❯ symbol
- Assumes a two-line prompt with pwd on first line

## 🤝 Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements!

Visit the repository at [https://github.com/diffficult/tgrab](https://github.com/diffficult/tgrab)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by the common need to grab previous command outputs in tmux sessions
- Icons provided by [Nerd Fonts](https://www.nerdfonts.com/)
