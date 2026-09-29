#!/bin/bash
#
# verifier.sh — Verification automatique du TP01 (decouverte de Git et GitHub)
# A executer SUR LE POSTE, en utilisateur normal (pas de sudo) :
#     ./scripts/verifier.sh [chemin du depot]      (par defaut : ~/tp-git/tp01-git)
#
# Le script ne modifie rien : il lit la configuration Git, la cle SSH et le depot.
# Seule action reseau : un « git fetch » pour comparer le depot local avec GitHub.
#

# Sorties des commandes en anglais, quelle que soit la langue du poste
export LC_ALL=C

DEPOT="${1:-$HOME/tp-git/tp01-git}"
SCORE=0
TOTAL=0

VERT="\033[0;32m"
ROUGE="\033[0;31m"
JAUNE="\033[0;33m"
GRAS="\033[1m"
RAZ="\033[0m"

titre() {
    echo
    echo -e "${GRAS}=== $1 ===${RAZ}"
}

# ok <description> <commande...>  -> +1 point si la commande reussit
ok() {
    local desc="$1"; shift
    TOTAL=$((TOTAL + 1))
    if "$@" >/dev/null 2>&1; then
        echo -e "  [${VERT}OK${RAZ}]     $desc"
        SCORE=$((SCORE + 1))
    else
        echo -e "  [${ROUGE}ECHEC${RAZ}]  $desc"
    fi
}

# pas_ok <description> <commande...>  -> +1 point si la commande ECHOUE
pas_ok() {
    local desc="$1"; shift
    TOTAL=$((TOTAL + 1))
    if "$@" >/dev/null 2>&1; then
        echo -e "  [${ROUGE}ECHEC${RAZ}]  $desc"
    else
        echo -e "  [${VERT}OK${RAZ}]     $desc"
        SCORE=$((SCORE + 1))
    fi
}

info() { echo -e "  [${JAUNE}INFO${RAZ}]   $1"; }

# --- Fonctions de test ---------------------------------------------------------

config_definie() { [ -n "$(git config --global "$1")" ]; }
config_vaut()    { [ "$(git config --global "$1")" = "$2" ]; }

# perms <fichier> <octal>
perms() { [ -e "$1" ] && [ "$(stat -c '%a' "$1")" = "$2" ]; }

# GitHub repond « Hi pseudo! You've successfully authenticated » (code de retour 1)
ssh_github() {
    ssh -T -o BatchMode=yes -o ConnectTimeout=8 \
        git@github.com 2>&1 | grep -q "successfully authenticated"
}

g() { git -C "$DEPOT" "$@"; }

est_un_depot()     { [ -d "$DEPOT/.git" ]; }
sur_main()         { [ "$(g branch --show-current)" = "main" ]; }
nb_commits_min()   { [ "$(g rev-list --count HEAD 2>/dev/null || echo 0)" -ge "$1" ]; }
fichier_suivi()    { g ls-files --error-unmatch "$1"; }
fichier_ignore()   { g check-ignore -q "$1"; }
arbre_propre()     { [ -z "$(g status --porcelain)" ]; }
remote_ssh()       { g config --get remote.origin.url | grep -Eq '^git@github\.com:[^/]+/tp01-git(\.git)?$'; }
remote_accessible(){ g fetch --quiet origin; }
tout_pousse()      { [ "$(g rev-parse HEAD)" = "$(g rev-parse origin/main 2>/dev/null)" ]; }

# Au moins un commit fait depuis l'interface web de GitHub (partie 6.4)
commit_web()       { g log --format='%cn' | grep -qx "GitHub"; }

# Des messages de commit varies (pas 6 fois « modif »)
messages_varies()  { [ "$(g log --format='%s' | sort -u | wc -l)" -ge 5 ]; }

# Le compte rendu contient des reponses jusqu'a la partie 7
cr_complet()       { grep -Eqi 'questions?[[:space:]]*7' "$DEPOT/COMPTE-RENDU.md"; }

# Aucune cle privee dans le depot
pas_de_cle_privee(){ ! g grep -q "BEGIN OPENSSH PRIVATE KEY" $(g rev-list --all) 2>/dev/null; }

# --- Verifications ---------------------------------------------------------------

echo -e "${GRAS}TP01 — Découverte de Git et GitHub : vérification${RAZ}"
echo "Dépôt vérifié : $DEPOT"

titre "Partie 2 — Configuration de Git"
ok "Nom configuré (user.name)"                    config_definie user.name
ok "E-mail configuré (user.email)"                config_definie user.email
ok "Branche par défaut : main"                    config_vaut init.defaultBranch main
command -v git >/dev/null && info "Auteur des commits : $(git config --global user.name) <$(git config --global user.email)>"

titre "Partie 3 — Premier dépôt"
if ! est_un_depot; then
    echo -e "  [${ROUGE}ECHEC${RAZ}]  $DEPOT n'est pas un dépôt Git : vérifiez le chemin passé au script."
    echo
    echo -e "${GRAS}Score : $SCORE / $((TOTAL + 1))${RAZ}"
    exit 1
fi
ok "Le dossier est un dépôt Git"                  est_un_depot
ok "Branche courante : main"                      sur_main
ok "README.md est suivi"                          fichier_suivi README.md
ok "COMPTE-RENDU.md est suivi"                    fichier_suivi COMPTE-RENDU.md
ok "memo-git.md est suivi"                        fichier_suivi memo-git.md
ok "Au moins 8 commits"                           nb_commits_min 8
ok "Messages de commit variés"                    messages_varies
info "Nombre de commits : $(g rev-list --count HEAD 2>/dev/null || echo 0)"

titre "Partie 4 — .gitignore"
ok ".gitignore est suivi"                         fichier_suivi .gitignore
ok "brouillon.txt est ignoré"                     fichier_ignore brouillon.txt
ok "Les fichiers *.log sont ignorés"              fichier_ignore erreurs.log
pas_ok "brouillon.txt n'est pas dans le dépôt"    fichier_suivi brouillon.txt

titre "Partie 5 — Clé SSH"
ok "Clé privée ~/.ssh/id_ed25519 présente"        test -f "$HOME/.ssh/id_ed25519"
ok "Clé publique ~/.ssh/id_ed25519.pub présente"  test -f "$HOME/.ssh/id_ed25519.pub"
ok "Clé privée protégée (600)"                    perms "$HOME/.ssh/id_ed25519" 600
ok "Authentification SSH auprès de GitHub"        ssh_github
ok "Aucune clé privée dans l'historique du dépôt" pas_de_cle_privee

titre "Partie 6 — Publication sur GitHub"
ok "Dépôt distant origin en SSH (git@github.com:…/tp01-git.git)" remote_ssh
ok "Dépôt distant accessible (git fetch)"         remote_accessible
ok "Un commit fait depuis l'interface web de GitHub, récupéré avec git pull" commit_web
ok "Aucune modification en attente (git status propre)" arbre_propre
ok "Tous les commits sont poussés sur GitHub"     tout_pousse

titre "Partie 7 — Compte rendu"
ok "COMPTE-RENDU.md contient la partie 7"         cr_complet

echo
if [ "$SCORE" -eq "$TOTAL" ]; then
    echo -e "${VERT}${GRAS}Score : $SCORE / $TOTAL — tout est bon, pensez à communiquer l'URL de votre dépôt !${RAZ}"
else
    echo -e "${GRAS}Score : $SCORE / $TOTAL${RAZ} — corrigez les points en ${ROUGE}ECHEC${RAZ}, puis relancez le script."
fi
