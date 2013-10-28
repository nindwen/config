import sys
import colorsys
from colorz import colorz

kuva =  sys.argv[1]
WALLPAPER = '/home/lumo/Kuvat/Taustat/' + kuva 
COLORS = '/home/lumo/.gitconf/master/System/colors/.generated'
XRESOURCES = '/home/lumo/.gitconf/master/System/colors/' + kuva

cols = ''
xres = """
"""

def normalize(hexv, minv=128, maxv=256):
    hexv = hexv[1:]
    r, g, b = (
        int(hexv[0:2], 16) / 256.0,
        int(hexv[2:4], 16) / 256.0,
        int(hexv[4:6], 16) / 256.0,
    )
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    minv = minv / 256.0
    maxv = maxv / 256.0
    if v < minv:
        v = minv
    if v > maxv:
        v = maxv
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return '#{:02x}{:02x}{:02x}'.format(int(r * 256), int(g * 256), int(b * 256))

if __name__ == '__main__':
    if len(sys.argv) == 2:
        n = 16
    else:
        n = int(sys.argv[2])


    i = 0
    with open('colorz.html', 'w') as f:
        f.write("""<img src="file://{}" height=200/>""".format(WALLPAPER))
        for c in colorz(WALLPAPER, n=n):
            # if i == 8:
            #     i += 1
            if i == 0:
                c = normalize(c, minv=0, maxv=32)
            elif i == 8:
                c = normalize(c, minv=128, maxv=192)
            elif i < 8:
                c = normalize(c, minv=160, maxv=224)
            else:
                c = normalize(c, minv=200, maxv=256)
            f.write("""
                <div style="background-color: {0}; width: 100%; height: 50px">{1}: {0}</div>
                """.format(c, i)
            )
            xres += """urxvt*color{}: {}\n""".format(i, c)
            cols += """export COLOR{}="{}"\n""".format(i, c)
            if i == 1:
                print(c)
            i += 1

    with open(XRESOURCES, 'w') as f:
        f.write(xres)
    with open(COLORS, 'w') as f:
        f.write(cols)
