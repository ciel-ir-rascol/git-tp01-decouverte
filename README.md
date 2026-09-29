# TP01 — Découverte de Git et GitHub

**1CIEL-IR — Durée : 3h — Fait suite au cours 01 (`git-cours01-decouverte`).**

> *Git va vous accompagner pendant les deux années du BTS : tous vos TP seront des dépôts, et votre compte GitHub deviendra une vitrine de votre travail. Dans ce TP, vous créez votre compte, vous faites vos premiers commits, puis vous publiez votre travail sur GitHub, exactement comme le font les développeurs et les administrateurs systèmes au quotidien.*

Ce TP se fait **entièrement sur votre poste**, dans le terminal. Pas besoin de compte GitHub pour lire ce sujet : vous en créerez un dans la partie 1.

📄 **Gardez à côté de vous le document à trous complété pendant le cours** : c'est votre aide-mémoire.

![La chaîne Git](figures/chaine-git.svg)

---

## 🚀 Avant de commencer

> [!IMPORTANT]
> **Ce que vous rendez**
>
> Pendant le TP, vous allez construire un dépôt nommé **`tp01-git`**. Il contiendra un fichier **`COMPTE-RENDU.md`** dans lequel vous répondez aux questions ❓ au fur et à mesure.
>
> **Ce dépôt est votre rendu** : à la fin de la séance, il doit être publié sur GitHub (partie 6), et vous communiquez son URL à l'enseignant.
>
> Les questions des parties 0 à 2 arrivent **avant** la création du dépôt : notez vos réponses sur une feuille ou dans un fichier texte, vous les recopierez dans `COMPTE-RENDU.md` à l'étape 3.6.

### Environnement de travail

| | |
| --- | --- |
| **Poste** | Ubuntu Desktop 24.04 LTS, Git déjà installé |
| **Terminal** | `Ctrl` + `Alt` + `T` |
| **Éditeur de texte** | `nano` dans le terminal (ou l'éditeur de votre choix) |
| **Navigateur** | pour GitHub |

### Rappels `nano`

| Touches | Action |
| --- | --- |
| `Ctrl` + `O` puis `Entrée` | Enregistrer |
| `Ctrl` + `X` | Quitter |
| `Ctrl` + `K` | Couper la ligne |

### En cas de blocage

- **`git status`** : Git indique presque toujours ce qu'il faut faire ensuite. Lisez son message **en entier**.
- Chaque commande Git a son aide : `git help commit`, `git help push`…
- La section **[En cas de problème](#-en-cas-de-problème)**, en fin de sujet, liste les erreurs les plus fréquentes.

---

## Sommaire

| Partie | Objectif | Durée indicative |
| :---: | --- | :---: |
| **0** | Préparer son poste | 5 min |
| **1** | Créer son compte GitHub | 20 min |
| **2** | Se présenter à Git | 10 min |
| **3** | Premier dépôt, premiers commits | 40 min |
| **4** | Explorer l'historique et réparer ses erreurs | 30 min |
| **5** | Créer sa clé SSH et la déclarer sur GitHub | 25 min |
| **6** | Publier son dépôt sur GitHub | 30 min |
| **7** | Cloner : travailler depuis deux endroits | 20 min |
| **Bonus** | Profil GitHub, conflit | — |

> [!NOTE]
> **Ce qu'on attend dans le compte rendu**
>
> Pour chaque question ❓ : la ou les commandes utilisées **et** le résultat obtenu (copié-collé du terminal). Quand une question demande « pourquoi », une phrase d'explication est attendue.
>
> Pour copier dans le terminal : sélectionner puis `Ctrl` + `Maj` + `C`. Pour coller : `Ctrl` + `Maj` + `V`.

---

## Partie 0 — Préparer son poste

Ouvrez un terminal et vérifiez que Git est installé :

```bash
git --version
```

Créez ensuite un dossier qui accueillera tous vos travaux Git, et placez-vous dedans :

```bash
mkdir -p ~/tp-git
cd ~/tp-git
```

### ❓ Question 0

Quelle version de Git est installée sur votre poste ?

---

## Partie 1 — Créer son compte GitHub

### 1.1 — Choisir son pseudo… avec soin

Votre pseudo GitHub sera **public** : il apparaîtra dans l'URL de tous vos dépôts (`github.com/pseudo`), et vous le garderez probablement toute votre carrière. Un recruteur ira le consulter.

| ✅ Bons exemples | ❌ À éviter |
| --- | --- |
| `lea-martin`, `lmartin-dev`, `leamartin31` | `xX_D4rkK1ller_Xx`, `lea2008`, `ciel-lea-rascol` |

> [!TIP]
> Évitez les références au lycée ou à l'année : dans trois ans, ce pseudo doit toujours avoir du sens.

### 1.2 — Créer le compte

1. Rendez-vous sur **[github.com/signup](https://github.com/signup)**.
2. **E-mail** : utilisez une adresse **personnelle** que vous garderez (l'adresse fournie par le lycée expirera à la fin de vos études).
3. **Mot de passe** : un mot de passe **solide**, que vous n'utilisez nulle part ailleurs.
4. **Username** : le pseudo choisi à l'étape 1.1.
5. Résolvez l'énigme de vérification, puis saisissez le **code reçu par e-mail**.
6. Les questions de personnalisation qui suivent sont facultatives : vous pouvez les passer (*Skip personalization*).

> [!NOTE]
> **Double authentification (2FA)**
>
> GitHub impose la double authentification aux comptes qui publient du code. Il vous la demandera dans les jours qui suivent la création du compte. Installez une application d'authentification sur votre téléphone (par exemple **Google Authenticator**, **Microsoft Authenticator** ou **FreeOTP**), et **conservez précieusement les codes de récupération** (*recovery codes*) que GitHub vous fournira : sans eux, un téléphone perdu = un compte perdu.

### 1.3 — Compléter son profil

Cliquez sur votre avatar (en haut à droite) → **Settings** → **Public profile** :

- **Name** : votre prénom et votre nom ;
- **Bio** (facultatif) : par exemple « Étudiant en BTS CIEL option IR ».

### ❓ Question 1

Donnez l'URL de votre profil GitHub (de la forme `https://github.com/pseudo`).

---

## Partie 2 — Se présenter à Git

Chaque commit enregistre le **nom** et l'**e-mail** de son auteur. Il faut donc les indiquer à Git, **une seule fois** par poste.

```bash
git config --global user.name "Prénom Nom"
git config --global user.email "adresse-du-compte-github@exemple.fr"
```

> [!IMPORTANT]
> Utilisez **la même adresse e-mail que celle de votre compte GitHub** : c'est grâce à elle que GitHub reliera vos commits à votre profil (avec votre avatar).

Deux réglages supplémentaires :

```bash
# La branche principale des nouveaux dépôts s'appellera « main » (comme sur GitHub)
git config --global init.defaultBranch main

# L'éditeur utilisé par Git quand il a besoin que vous écriviez un texte
git config --global core.editor nano
```

Vérifiez vos réglages :

```bash
git config --list --global
```

Ces réglages sont enregistrés dans un fichier texte de votre dossier personnel. Affichez-le :

```bash
cat ~/.gitconfig
```

### ❓ Question 2

1. Copiez la sortie de `git config --list --global`.
2. Que signifie l'option `--global` ? Dans quel fichier ces réglages sont-ils enregistrés ?

---

## Partie 3 — Premier dépôt, premiers commits

### 3.1 — Un dossier ordinaire

```bash
cd ~/tp-git
mkdir tp01-git
cd tp01-git
git status
```

### ❓ Question 3.1

Que répond `git status` ? Pourquoi ?

### 3.2 — Transformer le dossier en dépôt

```bash
git init
ls -la
git status
```

### ❓ Question 3.2

1. Quel dossier `git init` a-t-il créé ? Pourquoi ne le voyait-on pas avec un simple `ls` ?
2. Que répond maintenant `git status` ?

> [!WARNING]
> Ne modifiez **jamais** le contenu de `.git/` à la main, et ne le supprimez pas : c'est tout l'historique de votre dépôt.

### 3.3 — Un premier fichier

Créez le fichier `README.md` :

```bash
nano README.md
```

Écrivez-y le contenu suivant (en remplaçant par votre nom), puis enregistrez et quittez :

```markdown
# TP01 — Découverte de Git

Dépôt réalisé par Prénom Nom, 1CIEL-IR.

Ce dépôt contient mon compte rendu du TP01.
```

Puis :

```bash
git status
```

### ❓ Question 3.3

Dans quelle section `git status` range-t-il `README.md` ? Dans quelle **zone** de Git le fichier se trouve-t-il (répertoire de travail, zone de préparation ou dépôt) ?

### 3.4 — Préparer le fichier

```bash
git add README.md
git status
```

### ❓ Question 3.4

Qu'est-ce qui a changé dans la réponse de `git status` ? Dans quelle zone se trouve maintenant `README.md` ?

### 3.5 — Le premier commit

```bash
git commit -m "Création du README"
git status
git log
```

### ❓ Question 3.5

1. Copiez la sortie de `git log`.
2. Relevez : le **hash** du commit, son **auteur**, sa **date** et son **message**.
3. Combien de caractères comporte le hash ? En quelle base est-il écrit ? Combien de bits représente-t-il ?

### 3.6 — Le compte rendu entre dans le dépôt

À partir de maintenant, vos réponses vont dans le dépôt lui-même. Créez le fichier `COMPTE-RENDU.md` :

```bash
nano COMPTE-RENDU.md
```

Structurez-le ainsi, et recopiez-y vos réponses aux questions 0 à 3.5 :

```markdown
# Compte rendu — TP01 Git

## Question 0

La version de Git installée est ...

## Question 1

...
```

> [!TIP]
> Pour insérer une sortie de terminal dans un fichier Markdown, encadrez-la par trois accents graves (`` ``` ``) :
>
> ````markdown
> ```text
> commit 3f9a1c2e...
> Author: Léa Martin <lea@exemple.fr>
> ```
> ````

Enregistrez un commit contenant ce fichier :

```bash
git add COMPTE-RENDU.md
git commit -m "Ajout du compte rendu (questions 0 à 3.5)"
```

> [!IMPORTANT]
> **Jusqu'à la fin du TP**, après chaque question : complétez `COMPTE-RENDU.md`, puis faites un commit avec un message clair (`"Question 3.7"`, `"Questions 4.1 et 4.2"`…). Le nombre et la qualité de vos commits font partie de l'évaluation.

### 3.7 — Modifier un fichier suivi

Ajoutez une ligne à la fin de `README.md`, par exemple `Année scolaire 2026-2027.`, puis :

```bash
git status
git diff
```

### ❓ Question 3.7

1. Comment `git status` décrit-il maintenant `README.md` ?
2. Que montre `git diff` ? Que signifie le `+` en début de ligne ?

Enregistrez la modification :

```bash
git add README.md
git commit -m "Ajout de l'année scolaire dans le README"
```

### 3.8 — Un commit, une idée

Créez un fichier `memo-git.md`, votre **aide-mémoire personnel**, avec au moins les commandes `git init`, `git status`, `git add` et `git commit` et une phrase d'explication pour chacune.

**En même temps**, corrigez une faute (ou ajoutez une phrase) dans `COMPTE-RENDU.md`.

Vous avez maintenant **deux modifications sans rapport entre elles**. Faites **deux commits séparés** :

```bash
git status
git add memo-git.md
git commit -m "Création de l'aide-mémoire Git"
git add COMPTE-RENDU.md
git commit -m "..."        # à vous de trouver un message adapté
```

Affichez l'historique en version courte :

```bash
git log --oneline
```

### ❓ Question 3.8

1. Copiez la sortie de `git log --oneline`.
2. Pourquoi est-il préférable de faire deux commits plutôt qu'un seul `git add .` suivi d'un unique commit ?

---

## Partie 4 — Explorer l'historique et réparer ses erreurs

### 4.1 — Examiner un commit

Choisissez le hash (les 7 premiers caractères suffisent) du commit « Ajout de l'année scolaire dans le README » dans `git log --oneline`, puis :

```bash
git show <hash>
```

### ❓ Question 4.1

Que montre `git show` ? Quelles informations retrouve-t-on ?

### 4.2 — Revenir à la dernière version enregistrée

Simulons une fausse manipulation : on écrase le contenu du README.

```bash
echo "oups" > README.md
cat README.md
git status
```

Pas de panique : le fichier est **suivi** par Git, la dernière version enregistrée est dans le dépôt.

```bash
git restore README.md
cat README.md
git status
```

### ❓ Question 4.2

Qu'a fait `git restore` ? Aurait-on pu récupérer le fichier si on ne l'avait **jamais** commité ?

### 4.3 — Retirer un fichier de la zone de préparation

Créez un fichier `test.txt` contenant n'importe quoi, puis ajoutez-le par erreur :

```bash
echo "fichier de test" > test.txt
git add test.txt
git status
```

On change d'avis : `test.txt` ne doit pas partir dans le prochain commit.

```bash
git restore --staged test.txt
git status
```

### ❓ Question 4.3

Dans quelle zone se trouve `test.txt` après `git restore --staged` ? Le fichier a-t-il été supprimé du disque ?

### 4.4 — Ignorer des fichiers : `.gitignore`

Certains fichiers n'ont rien à faire dans un dépôt : brouillons, fichiers temporaires, journaux, et **surtout** mots de passe et clés.

Créez quelques fichiers « parasites » :

```bash
touch brouillon.txt erreurs.log debug.log
git status
```

Créez un fichier `.gitignore` à la racine du dépôt :

```bash
nano .gitignore
```

avec le contenu suivant :

```text
# Brouillons et fichiers de test
brouillon.txt
test.txt

# Journaux
*.log
```

```bash
git status
```

### ❓ Question 4.4

1. Quels fichiers ont disparu de la réponse de `git status` ? Que signifie `*.log` ?
2. Quel fichier y apparaît, en revanche ? Faut-il le committer ?

Committez le `.gitignore` (et votre compte rendu).

### 4.5 — Voyager dans le temps (en lecture seule)

Git permet de consulter un fichier **tel qu'il était** dans n'importe quel commit. Retrouvez le hash de votre **tout premier** commit, puis :

```bash
git show <hash>:README.md
```

Comparez ensuite deux commits :

```bash
git diff <hash_du_premier_commit> HEAD -- README.md
```

### ❓ Question 4.5

Que contenait `README.md` lors du premier commit ? Qu'est-ce qui a changé depuis ?

---

## Partie 5 — Créer sa clé SSH et la déclarer sur GitHub

Pour accepter un `git push`, GitHub doit être certain que c'est bien vous. Il refuse le mot de passe du compte : on utilise une **paire de clés SSH**.

| Fichier | Nom | Rôle | Se partage ? |
| --- | --- | --- | :---: |
| Clé **privée** | `id_ed25519` | Prouve votre identité. C'est votre secret. | ❌ **Jamais** |
| Clé **publique** | `id_ed25519.pub` | Se dépose sur GitHub. | ✅ Oui |

À chaque connexion, GitHub envoie un **défi** que seule votre clé privée sait résoudre ; il vérifie la réponse avec votre clé publique. Votre secret ne circule jamais sur le réseau.

> [!WARNING]
> **La clé privée ne quitte jamais votre poste.** On ne l'envoie pas par mail, on ne la copie pas sur une clé USB, on ne la committe **jamais** dans un dépôt. Si elle fuite, n'importe qui peut se faire passer pour vous.

### 5.1 — Vérifier si une clé existe déjà

```bash
ls -l ~/.ssh/
```

Si vous voyez déjà `id_ed25519` et `id_ed25519.pub`, passez à l'étape 5.3. Sinon (dossier vide ou inexistant), continuez.

### 5.2 — Générer la paire de clés

```bash
ssh-keygen -t ed25519 -C "adresse-du-compte-github@exemple.fr"
```

- `-t ed25519` : l'algorithme recommandé aujourd'hui (plus court et plus sûr que RSA) ;
- `-C` : un simple commentaire pour reconnaître la clé.

| Question posée | Que répondre |
| --- | --- |
| `Enter file in which to save the key` | **Entrée** (chemin par défaut `~/.ssh/id_ed25519`) |
| `Enter passphrase` | une **phrase de passe** (voir ci-dessous) |
| `Enter same passphrase again` | la même |

> [!NOTE]
> **Pourquoi une phrase de passe ?** Elle chiffre votre clé privée sur le disque : même copiée, elle reste inutilisable sans cette phrase. **Sur les postes du lycée, partagés, mettez-en une.** Rien ne s'affiche pendant la saisie : c'est normal. La session Ubuntu la mémorise ensuite (trousseau GNOME), vous ne la retaperez pas à chaque `push`.

Vérifiez le résultat :

```bash
ls -l ~/.ssh/
```

### ❓ Question 5.2

1. Quels fichiers ont été créés ? Lequel est la clé privée, lequel est la clé publique ?
2. Relevez les permissions de chacun. Pourquoi la clé privée est-elle en `rw-------` (600) ?

### 5.3 — Déclarer la clé publique sur GitHub

Affichez la clé **publique** :

```bash
cat ~/.ssh/id_ed25519.pub
```

Vous obtenez **une seule ligne** de la forme :

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... adresse-du-compte-github@exemple.fr
```

> [!CAUTION]
> Vérifiez que vous affichez bien le fichier **`.pub`**. Si la sortie commence par `-----BEGIN OPENSSH PRIVATE KEY-----`, c'est votre clé **privée** : n'en copiez rien, nulle part.

Sélectionnez la ligne **entière** et copiez-la (`Ctrl` + `Maj` + `C`), puis sur GitHub :

1. Avatar (en haut à droite) → **Settings**.
2. Menu de gauche : **SSH and GPG keys** → bouton **New SSH key**.
3. **Title** : un nom qui identifie la machine, par exemple `Poste lycée D116-10`.
4. **Key type** : `Authentication Key`.
5. **Key** : collez la ligne.
6. **Add SSH key** (GitHub peut vous redemander votre mot de passe ou votre code 2FA).

### 5.4 — Tester la connexion

```bash
ssh -T git@github.com
```

À la toute première connexion, SSH affiche l'**empreinte** du serveur et demande confirmation : répondez `yes`. Réponse attendue :

```text
Hi VOTRE_PSEUDO! You've successfully authenticated, but GitHub does not provide shell access.
```

> [!NOTE]
> « does not provide shell access » est **normal** : GitHub n'est pas un serveur sur lequel on ouvre une session, il n'accepte que les opérations Git. Voir votre pseudo affiché signifie que tout fonctionne.

### ❓ Question 5.4

1. Copiez la réponse de `ssh -T git@github.com`.
2. Expliquez avec vos mots pourquoi on peut sans danger donner sa clé publique à GitHub, mais jamais sa clé privée.

---

## Partie 6 — Publier son dépôt sur GitHub

### 6.1 — Créer un dépôt vide sur GitHub

1. Sur GitHub, bouton **+** (en haut à droite) → **New repository**.
2. **Repository name** : `tp01-git`.
3. **Public**.
4. **Ne cochez rien d'autre** : pas de README, pas de `.gitignore`, pas de licence. Le dépôt doit être **vide**, puisque vous avez déjà votre historique en local.
5. **Create repository**.

GitHub affiche une page d'accueil avec des instructions. Vérifiez que le bouton **SSH** est sélectionné (et non HTTPS) et repérez l'URL de la forme :

```text
git@github.com:VOTRE_PSEUDO/tp01-git.git
```

### 6.2 — Relier le dépôt local au dépôt distant

Dans le terminal, **depuis `~/tp-git/tp01-git`** :

```bash
git remote add origin git@github.com:VOTRE_PSEUDO/tp01-git.git
git remote -v
```

`origin` est le nom donné par convention au dépôt distant principal.

### 6.3 — Premier `push`

```bash
git push -u origin main
```

L'option `-u` (*upstream*) mémorise que votre branche `main` locale correspond à `main` sur `origin`. Les fois suivantes, un simple `git push` suffira.

Rechargez la page de votre dépôt sur GitHub : vos fichiers apparaissent. Cliquez sur **commits** (l'icône d'horloge, au-dessus de la liste des fichiers) pour voir votre historique.

### ❓ Question 6.3

1. Copiez la sortie de `git remote -v` et de `git push -u origin main`.
2. L'historique affiché par GitHub est-il le même que celui de `git log --oneline` ? Le fichier `brouillon.txt` est-il sur GitHub ? Pourquoi ?

### 6.4 — Une modification faite « ailleurs »

Sur la page GitHub de votre dépôt, ouvrez `README.md` et cliquez sur le **crayon** ✏️ (*Edit this file*). Ajoutez une ligne, par exemple `Modifié depuis l'interface web de GitHub.`, puis **Commit changes…** avec un message clair.

Revenez dans le terminal :

```bash
git status
cat README.md
```

### ❓ Question 6.4 a

Votre dépôt local contient-il la modification ? `git status` vous prévient-il qu'il existe un commit plus récent sur GitHub ? Pourquoi ?

Récupérez le nouveau commit :

```bash
git pull
cat README.md
git log --oneline
```

### ❓ Question 6.4 b

Que s'est-il passé ? Qui est l'auteur du dernier commit ?

### 6.5 — La boucle complète

Complétez votre `COMPTE-RENDU.md`, puis faites le cycle complet :

```bash
git status
git add COMPTE-RENDU.md
git commit -m "Questions 6.3 et 6.4"
git push
```

Vérifiez sur GitHub que le commit est arrivé.

### ❓ Question 6.5

Complétez le schéma suivant (à recopier dans votre compte rendu) en indiquant la commande qui fait passer d'une zone à l'autre :

```text
Répertoire de travail --( ? )--> Zone de préparation --( ? )--> Dépôt local --( ? )--> GitHub
          ^                                                                               |
          +--------------------------------------( ? )------------------------------------+
```

---

## Partie 7 — Cloner : travailler depuis deux endroits

En BTS, vous travaillerez au lycée **et** chez vous. Simulons un second ordinateur en clonant votre dépôt dans un autre dossier.

### 7.1 — Cloner son propre dépôt

```bash
cd ~/tp-git
git clone git@github.com:VOTRE_PSEUDO/tp01-git.git tp01-git-maison
cd tp01-git-maison
git log --oneline
ls -la
```

### ❓ Question 7.1

1. Le clone contient-il tout l'historique, ou seulement la dernière version des fichiers ?
2. Le fichier `brouillon.txt` est-il présent dans le clone ? Pourquoi ?
3. Avez-vous eu besoin de faire `git init` ou `git remote add` ? Vérifiez avec `git remote -v`.

### 7.2 — Aller-retour entre les deux copies

**À la « maison »** (`~/tp-git/tp01-git-maison`) : ajoutez une commande (par exemple `git log --oneline`) à votre `memo-git.md`, puis `add`, `commit` et `push`.

**Au « lycée »** (`~/tp-git/tp01-git`) :

```bash
cd ~/tp-git/tp01-git
git pull
cat memo-git.md
```

### ❓ Question 7.2

Expliquez pourquoi il faut prendre l'habitude de faire `git pull` **en début de séance** et `git push` **en fin de séance**.

> [!TIP]
> Une fois cette partie terminée, vous pouvez supprimer le dossier `~/tp-git/tp01-git-maison` : tout son contenu est sur GitHub. Continuez à travailler dans `~/tp-git/tp01-git`.

### 7.3 — Cloner le dépôt du TP et lancer l'auto-vérification

Ce sujet est lui-même un dépôt Git. Clonez-le, en **HTTPS** cette fois (possible sans clé, car le dépôt est public) :

```bash
cd ~/tp-git
git clone https://github.com/ciel-ir-rascol/git-tp01-decouverte.git
```

Lancez le script de vérification sur **votre** dépôt :

```bash
~/tp-git/git-tp01-decouverte/scripts/verifier.sh ~/tp-git/tp01-git
```

Corrigez ce qui est signalé en rouge, puis relancez le script.

### ❓ Question 7.3

1. Copiez le résultat final du script.
2. Essayez de modifier un fichier du dépôt du TP (`~/tp-git/git-tp01-decouverte`), puis de faire `commit` et `push`. Que se passe-t-il ? Pourquoi ?

> [!NOTE]
> Si Git vous demande un *Username*, interrompez-le avec `Ctrl` + `C` : c'est déjà une réponse à la question.

> [!NOTE]
> Pour travailler sur le dépôt de quelqu'un d'autre, on en fait d'abord une **copie sur son propre compte** : un ***fork***. C'est ainsi que vous récupérerez les sujets des prochains TP.

---

## 🏁 Fin du TP : rendu

1. Vérifiez que `COMPTE-RENDU.md` contient toutes vos réponses.
2. Dernier cycle : `git status`, `git add`, `git commit`, `git push`.
3. Relancez le script de vérification : tout doit être au vert.
4. Vérifiez sur GitHub que tout y est.
5. Communiquez à l'enseignant l'URL de votre dépôt : `https://github.com/VOTRE_PSEUDO/tp01-git`.

---

## 🏆 Bonus

### Bonus 1 — Votre profil GitHub

GitHub affiche sur votre page de profil le `README.md` d'un dépôt **qui porte exactement le nom de votre pseudo**.

1. Créez sur GitHub un dépôt public nommé `VOTRE_PSEUDO` (GitHub affiche un message spécial : ✨ *You found a secret!*). Cochez cette fois **Add a README file**.
2. Clonez-le en SSH sur votre poste.
3. Rédigez une courte présentation en Markdown (qui vous êtes, votre formation, ce que vous apprenez). Pas d'informations personnelles sensibles (adresse, téléphone…).
4. `add`, `commit`, `push`, et admirez votre page `https://github.com/VOTRE_PSEUDO`.

### Bonus 2 — Provoquer (et résoudre) un conflit

1. Sur GitHub, modifiez la **première ligne** de `README.md` (le titre) et commitez.
2. **Sans faire de `pull`**, modifiez aussi la première ligne de `README.md` en local, **différemment**, puis `add` et `commit`.
3. Tentez `git push` : il est refusé. Lisez le message.
4. Faites `git pull`. Git annonce un **conflit**. Ouvrez `README.md` : Git y a placé les deux versions entre des marqueurs `<<<<<<<`, `=======` et `>>>>>>>`.
5. Éditez le fichier pour ne garder que la version voulue (et supprimez les marqueurs), puis `git add README.md`, `git commit` et `git push`.

Expliquez dans votre compte rendu pourquoi le conflit est apparu et comment vous l'avez résolu.

> [!NOTE]
> Si `git pull` affiche un message à propos de *divergent branches* et vous demande de choisir une stratégie, tapez d'abord :
> ```bash
> git config --global pull.rebase false
> ```
> puis relancez `git pull`.

---

## 🆘 En cas de problème

| Symptôme | Cause probable | Solution |
| --- | --- | --- |
| `fatal: not a git repository` | Vous n'êtes pas dans le dossier du dépôt | `cd ~/tp-git/tp01-git` puis `pwd` pour vérifier |
| `Author identity unknown` / `Please tell me who you are` | Nom et e-mail non configurés | Refaire la partie 2 |
| `nothing to commit` / `rien à valider` | Aucune modification, ou oubli de `git add` | `git status` pour voir où sont vos fichiers |
| Un éditeur s'ouvre pendant `git commit` | Vous avez oublié `-m "message"` | Écrire le message sur la 1re ligne, `Ctrl`+`O`, `Entrée`, `Ctrl`+`X` |
| `Permission denied (publickey)` | Clé non déclarée sur GitHub, ou pas la bonne | Refaire l'étape 5.3, vérifier avec `ssh -T git@github.com` |
| `WARNING: UNPROTECTED PRIVATE KEY FILE!` | Permissions trop ouvertes sur la clé privée | `chmod 600 ~/.ssh/id_ed25519` |
| `git push` demande un *Username* | Le dépôt distant est en **HTTPS** | Voir ci-dessous |
| `error: remote origin already exists` | `git remote add` déjà fait | `git remote set-url origin git@github.com:PSEUDO/tp01-git.git` |
| `! [rejected] main -> main (fetch first)` | GitHub contient des commits que vous n'avez pas | `git pull`, puis `git push` |
| `src refspec main does not match any` | Aucun commit, ou branche nommée `master` | `git log` ; `git branch -M main` pour renommer la branche |
| `GH007: Your push would publish a private email address` | Option de confidentialité de l'e-mail activée sur GitHub | Sur GitHub, *Settings → Emails* : décocher **Block command line pushes that expose my email**, puis relancer `git push` |

### Reconnaître les deux formats d'URL

| Protocole | Forme de l'URL | Pour pousser |
| --- | --- | --- |
| SSH ✅ | `git@github.com:PSEUDO/depot.git` | clé SSH, automatique |
| HTTPS | `https://github.com/PSEUDO/depot.git` | jeton à saisir : à éviter |

Pour passer un dépôt déjà cloné de HTTPS à SSH :

```bash
git remote -v
git remote set-url origin git@github.com:PSEUDO/depot.git
git remote -v
```

---

## 📚 Pour aller plus loin

- Le livre ***Pro Git***, de Scott Chacon (cofondateur de GitHub), gratuit et en français : <https://git-scm.com/book/fr/v2>
- Un jeu pour comprendre l'historique et les branches : <https://learngitbranching.js.org/?locale=fr_FR>
- Les cours interactifs de GitHub : <https://skills.github.com>
- La syntaxe Markdown sur GitHub : <https://docs.github.com/fr/get-started/writing-on-github>

---

*Licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr) — BTS CIEL option IR, Lycée Louis Rascol, Albi.*
