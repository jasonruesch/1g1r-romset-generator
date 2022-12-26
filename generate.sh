SOURCE_DIR="/Volumes/T7/ROMS/_src"
TARGET_DIR="/Volumes/T7/ROMs/_dest"

SYSTEM=$1
dryrun=$2

if [ "$SYSTEM" = "--dry-run" ]; then
  SYSTEM="$dryrun"
  dryrun="--dry-run"
fi

if [ -z "$SYSTEM" ]; then
  echo "Usage: $0 <system>"
  exit 1
fi

if [ ! -d "$SOURCE_DIR/$SYSTEM" ]; then
  echo "System not found: $SYSTEM"
  exit 1
fi

case $SYSTEM in
  atari2600)
    DATFILE="Atari - 2600 (Parent-Clone) (20221220-000803).dat"
    ;;
  atari5200)
    DATFILE="Atari - 5200 (Parent-Clone) (20220405-183755).dat"
    ;;
  atari7800)
    DATFILE="Atari - 7800 (Parent-Clone) (20220714-205237).dat"
    ;;
  lynx)
    DATFILE="Atari - Lynx (Parent-Clone) (20220513-205052).dat"
    ;;
  n64)
    DATFILE="Nintendo - Nintendo 64 (BigEndian) (Parent-Clone) (20221226-060452).dat"
    ;;
  nes)
    DATFILE="Nintendo - Nintendo Entertainment System (Headered) (Parent-Clone) (20221225-203418).dat"
    ;;
  snes)
    DATFILE="Nintendo - Super Nintendo Entertainment System (Parent-Clone) (20221226-070605).dat"
    ;;
  megadrive)
    DATFILE="Sega - Mega Drive - Genesis (Parent-Clone) (20221214-091705).dat"
    ;;
  psx)
    DATFILE="Sony - PlayStation (PS one Classics) (PSN) (Parent-Clone) (20220402-020621).dat"
    ;;
esac

if [ ! -f "_datfiles/$DATFILE" ]; then
  echo "Datfile not found: $DATFILE"
  exit 1
fi

if [ "$dryrun" = "--dry-run" ]; then
  echo "Dry Run: $SYSTEM"
  python3 generate.py -r USA -l en --no-all --no-unlicensed -d "_datfiles/$DATFILE" -i "$SOURCE_DIR/$SYSTEM"
  echo "Dry Run: $SYSTEM"
  exit 0
fi

if [ ! -d "$TARGET_DIR/$SYSTEM" ]; then
  mkdir -p "$TARGET_DIR/$SYSTEM"
fi

python3 generate.py -r USA -l en --no-all --no-unlicensed -d "_datfiles/$DATFILE" -i "$SOURCE_DIR/$SYSTEM" -o "$TARGET_DIR/$SYSTEM"
