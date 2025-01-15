#!/bin/bash

# Modalità dry run: se impostata a "true", lo script non eseguirà le azioni ma le mostrerà
DRY_RUN=false

# Funzione per eseguire comandi con supporto per il dry run
run() {
    if [ "$DRY_RUN" = true ]; then
        echo "[Dry Run] $*"
    else
        eval "$@"
    fi
}

# Funzione per il comando "config"
config() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# Aggiungi .dotfiles a .gitignore
run "echo '.dotfiles' >> $HOME/.gitignore"

# Clona il repository dei dotfiles in modalità bare
run "git clone --bare https://github.com/ricalbr/.dotfiles $HOME/.dotfiles"

# Configura Git per ignorare i file non tracciati
run "config config --local status.showUntrackedFiles no"

# Crea una directory di backup
BACKUP_DIR=$HOME/.config-backup
run "mkdir -p $BACKUP_DIR"

# Tenta di fare il checkout dei file
echo "Effettuando il checkout dei file..."
if $DRY_RUN || config checkout 2>/dev/null; then
    echo "Checkout completato con successo (o simulato)."
else
    echo "Alcuni file potrebbero già esistere. Spostandoli in $BACKUP_DIR..."

    # Trova i file in conflitto e spostali nella directory di backup
    config checkout 2>&1 | grep "^\s" | awk '{print $1}' | while read -r file; do
        if [ -e "$HOME/$file" ]; then
            run "mv $HOME/$file $BACKUP_DIR/"
        fi
    done

    # Riprova il checkout dopo aver gestito i conflitti
    run "config checkout"
fi

# Imposta zsh come shell predefinita, se non lo è già
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Impostando zsh come shell predefinita..."
    run "chsh -s $(which zsh)"
else
    echo "zsh è già la shell predefinita."
fi

echo "Script completato. Modalità Dry Run: $DRY_RUN"

