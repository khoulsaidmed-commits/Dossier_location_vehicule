<?php
// index.php
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KAMK — Location de Véhicules Premium</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        /* ===================== RESET & BASE ===================== */
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --green:        #007A3D;
            --green-dim:    #005C2D;
            --green-light:  #00A052;
            --blue:         #00A0DC;
            --blue-dim:     #007BAD;
            --red:          #D7141A;
            --accent:       #007A3D;
            --accent-dim:   #005C2D;
            --bg-page:      #F7F8FA;
            --bg-white:     #FFFFFF;
            --bg-light:     #F0F2F5;
            --bg-dark:      #0D1B2A;
            --border:       #E2E5EA;
            --text-black:   #0D1B2A;
            --text-dark:    #1A1A2E;
            --text-mid:     #444455;
            --text-grey:    #777788;
            --font-serif:   'Cormorant Garamond', Georgia, serif;
            --font-sans:    'Montserrat', sans-serif;
        }

        html { scroll-behavior: smooth; }

        p, li { color: #111111 !important; }
        body {
            background-color: #f0f4f8;
            background-image:
                linear-gradient(rgba(255,255,255,0.82), rgba(255,255,255,0.82)),
                url('../images/bg_djibouti.png');
            background-attachment: fixed;
            background-size: cover;
            background-position: center;
            color: #111111;
            font-family: var(--font-sans);
            font-weight: 300;
            overflow-x: hidden;
        }

        /* ===================== SCROLLBAR ===================== */
        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-track { background: #FFFFFF; }
        ::-webkit-scrollbar-thumb { background: var(--green); border-radius: 2px; }

        /* ===================== UTILITY ===================== */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 40px;
        }

        
        /* ===== HEADER ===== */
        header {
            position: fixed; top:0; left:0; right:0; z-index:200;
            padding: 18px 0;
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(14px);
            border-bottom: 3px solid var(--green);
            box-shadow: 0 1px 12px rgba(0,0,0,0.06);
        }
        .container { max-width:1280px; margin:0 auto; padding:0 40px; }
        header .container { display:flex; align-items:center; justify-content:space-between; }
        .logo { text-decoration:none; line-height:1; }
        .logo-main { font-family:var(--font-serif); font-size:1.8rem; font-weight:800; letter-spacing:0.25em; color:var(--red) !important; display:block; }
        .logo-sub { font-size:0.5rem; letter-spacing:0.4em; text-transform:uppercase; color:#111111; margin-top:2px; display:block; }
        nav ul { list-style:none; display:flex; align-items:center; gap:32px; }
        nav ul li a { text-decoration:none; font-size:0.68rem; font-weight:500; letter-spacing:0.12em; text-transform:uppercase; color:#111111; transition:color 0.3s; position:relative; }
        nav ul li a::after { content:''; position:absolute; bottom:-3px; left:0; width:0; height:2px; background:var(--green); transition:width 0.3s; }
        nav ul li a:hover, nav ul li a.active { color:var(--green); }
        nav ul li a:hover::after, nav ul li a.active::after { width:100%; }
        .btn-nav { padding:9px 20px; border:2px solid var(--blue); color:var(--green) !important; border-radius:2px; transition:background 0.3s, color 0.3s !important; }
        .btn-nav::after { display:none !important; }
        .btn-nav:hover { background:var(--green) !important; color:#fff !important; }
        .btn-questions {
            display:inline-flex; align-items:center; gap:7px;
            padding:9px 18px;
            background: linear-gradient(135deg, var(--red), #B71C1C);
            color:#fff !important; border:none; border-radius:2px;
            font-size:0.65rem; font-weight:700; letter-spacing:0.15em;
            text-transform:uppercase; text-decoration:none;
            transition:opacity 0.3s, transform 0.2s;
            white-space:nowrap;
        }
        .btn-questions::after { display:none !important; }
        .btn-questions:hover { opacity:0.88; transform:translateY(-1px); color:#fff !important; }
        .btn-questions .bq-dot {
            width:7px; height:7px; border-radius:50%;
            background:#fff; opacity:0.9;
            animation:bq-pulse 2s ease infinite;
        }
        @keyframes bq-pulse { 0%,100%{transform:scale(1);opacity:0.9} 50%{transform:scale(1.4);opacity:0.5} }


        /* SECTIONS ALTERNÉES */
        .section-services { background: var(--bg-page); }
        .section-highlight { background: var(--bg-page); }
        .section-fleet { background: var(--bg-light); }
        .section-zones { background: var(--bg-white); }
        .section-types { background: var(--bg-light); }
        .section-cta { background: var(--bg-dark); }
        .section-map { background: var(--bg-white); }
        .section-pub { background: var(--bg-page); }


        /* ===== THEME TOGGLE ===== */
        .theme-toggle {
            width: 40px; height: 40px;
            border-radius: 50%;
            border: 1.5px solid var(--border, #E2E5EA);
            background: transparent;
            cursor: pointer;
            font-size: 1rem;
            display: flex; align-items: center; justify-content: center;
            transition: all 0.3s;
        }
        .theme-toggle:hover { background: var(--bg-light, #F0F2F5); transform: rotate(20deg); }

        /* MODE SOMBRE */
        body.dark-mode {
            --bg-page:   #0D1B2A;
            --bg-white:  #152234;
            --bg-light:  #1C2E44;
            --bg-dark:   #060E18;
            --border:    rgba(255,255,255,0.08);
            --text-black:#F0F4F8;
            background-color: #0D1B2A;
            color: #F0F4F8;
        }
        body.dark-mode header {
            background: rgba(13,27,42,0.97) !important;
            border-bottom-color: var(--green) !important;
        }
        body.dark-mode .section-title { color: var(--green-light, #00A052); }
        body.dark-mode .fleet-card,
        body.dark-mode .service-card,
        body.dark-mode .type-card {
            background: #152234 !important;
            border-color: rgba(255,255,255,0.08) !important;
            color: #F0F4F8;
        }
        body.dark-mode .fleet-card h4,
        body.dark-mode .service-card h4,
        body.dark-mode h3, body.dark-mode h4 { color: var(--green, #007A3D); }
        body.dark-mode p, body.dark-mode li { color: rgba(240,244,248,0.8); }
        body.dark-mode .highlight-inner { background: #152234; border-color: rgba(255,255,255,0.08); }
        body.dark-mode .highlight-content { background: #152234; }
        body.dark-mode .section-map { background: #152234; }
        body.dark-mode nav ul li a { color: rgba(255,255,255,0.7); }
        body.dark-mode .logo-sub { color: rgba(255,255,255,0.5); }
        body.dark-mode .footer-col p,
        body.dark-mode .footer-col ul li a { color: rgba(255,255,255,0.6); }
        body.dark-mode .zone-card { border-color: rgba(255,255,255,0.1); }
        body.dark-mode body { background-image: linear-gradient(rgba(13,27,42,0.95), rgba(13,27,42,0.95)), url('../images/bg_djibouti.png'); }

        /* Transition douce */
        body, header, .fleet-card, .service-card, .highlight-inner,
        .highlight-content, .section-map, .type-card, nav ul li a {
            transition: background 0.4s ease, color 0.3s ease, border-color 0.3s ease;
        }


                .section-cta p,
        .section-cta li,
        footer p,
        footer li,
        .hero p { color: rgba(255,255,255,0.85) !important; }


        /* ===== RÈGLE CONTRASTE AUTOMATIQUE ===== */
        /* Fond clair → texte noir */
        body, p, li, span, div, td, th, label { color: #111111; }

        /* Fond sombre → texte blanc automatiquement */
        .section-cta,        .section-cta *,
        .hero,               .hero *:not(.btn-reserve):not(.btn-outline),
        footer,              footer *,
        .bg-dark,            .bg-dark *,
        [style*="background:var(--bg-dark)"] *,
        [style*="background:#0D1B2A"] *,
        [style*="background:linear-gradient(135deg,var(--bg-dark"] *,
        [style*="background:linear-gradient(135deg,#0D1B2A"] *,
        .avis-card[style*="background:var(--bg-dark"] *,
        .avis-card[style*="background:var(--bg-dark"] p { color: rgba(255,255,255,0.88) !important; }

        /* Titres → toujours vert sur fond clair */
        h1, h2, h3, h4 { color: var(--green); font-weight: 700; }
        h1 em, h2 em, h3 em, h4 em { color: var(--blue); font-style: normal; }

        /* Titres sur fond sombre → blanc */
        .section-cta h1, .section-cta h2, .section-cta h3, .section-cta h4,
        .hero h1, .hero h2, .hero h3,
        footer h4, footer h5 { color: #FFFFFF !important; }

        /* Logo toujours rouge */
        .logo-brand { color: var(--red) !important; }

        /* Nav liens → noir sur fond clair */
        nav ul li a { color: #111111; }
        nav ul li a:hover { color: var(--green); }

        /* Boutons → toujours leur couleur propre */
        .btn-nav, .btn-questions, .btn-reserve, .btn-outline { color: inherit; }

        /* Section hero fond sombre : tout en blanc */
        .hero { color: #FFFFFF; }
        .hero p, .hero span, .hero li { color: rgba(255,255,255,0.85) !important; }

        /* Météo widget fond sombre → blanc */
        #meteo-widget, #meteo-widget * { color: #FFFFFF !important; }

        /* Avis carte sombre (carte du milieu) */
        .avis-card[style*="background:var(--bg-dark"],
        .avis-card[style*="background:var(--bg-dark"] p,
        .avis-card[style*="background:var(--bg-dark"] div { color: rgba(255,255,255,0.88) !important; }

        /* Section agence KAMK fond sombre */
        .section-agence *, .bg-dark * { color: #FFFFFF !important; }

        /* Eyebrow labels */
        .section-eyebrow span { color: var(--green); font-weight: 600; }

        /* Textes secondaires/petits sur fond clair */
        .card-year, .footer-copy, .meta-text { color: #555555 !important; }


        /* ===== HERO LOGO + ÉTOILE ===== */
        .hero-logo-wrap {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 32px;
            animation: heroFadeIn 1.2s 0.1s ease both;
        }
        .hero-star {
            width: 52px; height: 52px;
            filter: drop-shadow(0 4px 12px rgba(215,20,26,0.5));
            animation: starPulse 3s ease-in-out infinite;
        }
        @keyframes starPulse {
            0%, 100% { filter: drop-shadow(0 4px 12px rgba(215,20,26,0.5)); }
            50%       { filter: drop-shadow(0 4px 20px rgba(215,20,26,0.9)); }
        }
        .hero-logo-text {
            display: flex;
            flex-direction: column;
        }
        .hero-logo-brand {
            font-family: var(--font-serif);
            font-size: 2.8rem;
            font-weight: 800;
            color: #FFFFFF;
            letter-spacing: 0.08em;
            line-height: 1;
            text-shadow: 0 2px 20px rgba(0,0,0,0.4);
        }
        .hero-logo-sub {
            font-size: 0.55rem;
            font-weight: 500;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: rgba(255,255,255,0.65);
            margin-top: 4px;
        }

        /* Textes hero toujours blancs */
        .hero-eyebrow span { color: rgba(255,255,255,0.75) !important; }
        .hero h2 { color: #FFFFFF !important; }
        .hero h2 em { color: var(--blue) !important; }
        .hero-desc { color: rgba(255,255,255,0.82) !important; }
        .hero-stats .stat-number { color: #FFFFFF !important; }
        .hero-stats .stat-label { color: rgba(255,255,255,0.6) !important; }
        .scroll-indicator span { color: rgba(255,255,255,0.5) !important; }

        /* ===================== HERO ===================== */
        .hero {
            position: relative;
            height: 100vh;
            min-height: 700px;
            display: flex;
            align-items: center;
            overflow: hidden;
        }

        /* Photo de fond */
        .hero-bg {
            position: absolute;
            inset: 0;
            background:
                url('images/hero_bg.png') center center / cover no-repeat;
        }

        /* Overlay sombre dégradé pour lisibilité du texte */
        .hero-bg::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(
                105deg,
                rgba(10, 22, 40, 0.82) 0%,
                rgba(10, 22, 40, 0.65) 50%,
                rgba(10, 22, 40, 0.30) 100%
            );
        }

        /* Bande couleurs drapeau en bas du hero */
        .hero-bg::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--green) 50%, var(--blue) 50%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
            animation: heroFadeIn 1.2s ease both;
        }

        @keyframes heroFadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .hero-eyebrow {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 28px;
            animation: heroFadeIn 1.2s 0.2s ease both;
        }
        .hero-eyebrow span {
            font-size: 0.65rem;
            font-weight: 500;
            letter-spacing: 0.4em;
            text-transform: uppercase;
            color: var(--green);
        }
        .hero-eyebrow::before {
            content: '';
            display: block;
            width: 40px; height: 1px;
            background: var(--green);
        }

        .hero h2 {
            font-family: var(--font-serif); font-weight: 700;
            font-size: clamp(3rem, 6vw, 5.5rem);
            font-weight: 300;
            line-height: 1.08;
            letter-spacing: 0.02em;
            color: #111111;
            margin-bottom: 12px;
            animation: heroFadeIn 1.2s 0.35s ease both;
        }

        .hero h2 em {
            font-style: italic;
            color: var(--green);
        }

        .hero-desc {
            font-size: 0.85rem;
            font-weight: 300;
            line-height: 1.9;
            color: #111111;
            max-width: 480px;
            margin: 24px 0 44px;
            animation: heroFadeIn 1.2s 0.5s ease both;
        }

        .hero-actions {
            display: flex;
            align-items: center;
            gap: 30px;
            animation: heroFadeIn 1.2s 0.65s ease both;
        }

        .btn-primary {
            display: inline-block;
            padding: 16px 38px;
            background: var(--green);
            color: #111111;
            text-decoration: none;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 0.25em;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
            transition: color 0.4s;
        }
        .btn-primary::before {
            content: '';
            position: absolute;
            inset: 0;
            background: #FFFFFF;
            transform: translateX(-100%);
            transition: transform 0.4s cubic-bezier(0.77,0,0.18,1);
        }
        .btn-primary:hover { color: var(--green); }
        .btn-primary:hover::before { transform: translateX(0); }
        .btn-primary span { position: relative; z-index: 1; }

        .btn-ghost {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            font-size: 0.7rem;
            font-weight: 500;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: #111111;
            transition: color 0.3s;
        }
        .btn-ghost svg { transition: transform 0.3s; }
        .btn-ghost:hover { color: #111111; }
        .btn-ghost:hover svg { transform: translateX(5px); }

        /* Floating stats */
        .hero-stats {
            position: absolute;
            bottom: 80px; right: 0;
            display: flex;
            gap: 1px;
            z-index: 2;
            animation: heroFadeIn 1.2s 0.8s ease both;
        }
        .stat {
            padding: 28px 36px;
            background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.1);
            border: 1px solid rgba(0,160,220,0.12);
            text-align: center;
            backdrop-filter: blur(10px);
        }
        .stat-number {
            font-family: var(--font-serif); font-weight: 700;
            font-size: 2.2rem;
            font-weight: 300;
            color: var(--green);
            line-height: 1;
        }
        .stat-label {
            font-size: 0.6rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: #111111;
            margin-top: 6px;
        }

        /* Scroll indicator */
        .scroll-indicator {
            position: absolute;
            bottom: 40px; left: 50%;
            transform: translateX(-50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            z-index: 2;
            animation: heroFadeIn 1.5s 1s ease both;
        }
        .scroll-indicator span {
            font-size: 0.55rem;
            letter-spacing: 0.35em;
            text-transform: uppercase;
            color: #111111;
        }
        .scroll-line {
            width: 1px; height: 50px;
            background: linear-gradient(to bottom, transparent, var(--bg-page));
            animation: scrollPulse 2s ease infinite;
        }
        @keyframes scrollPulse {
            0%, 100% { transform: scaleY(1); opacity: 1; }
            50% { transform: scaleY(0.5); opacity: 0.4; }
        }

        /* ===================== SECTION — SERVICES ===================== */
        .section-services {
            padding: 140px 0;
            position: relative;
        }

        .section-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 80px;
        }

        .section-eyebrow {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 18px;
        }
        .section-eyebrow span {
            font-size: 0.62rem;
            font-weight: 500;
            letter-spacing: 0.4em;
            text-transform: uppercase;
            color: var(--green);
        }
        .section-eyebrow::before {
            content: '';
            width: 30px; height: 1px;
            background: var(--green);
        }

        .section-title { color: var(--green);
            font-family: var(--font-serif); font-weight: 700;
            font-size: clamp(2rem, 4vw, 3.5rem);
            font-weight: 300;
            line-height: 1.1;
            letter-spacing: 0.02em;
        }
        .section-title em {
            font-style: italic;
            color: var(--blue);
        }

        /* Login buttons in section header */
        .login-buttons {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: flex-end;
        }

        .login-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            font-size: 0.68rem;
            font-weight: 500;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            padding: 12px 22px;
            border: 1px solid;
            position: relative;
            overflow: hidden;
            transition: color 0.35s;
            white-space: nowrap;
        }
        .login-btn::before {
            content: '';
            position: absolute;
            inset: 0;
            transform: translateX(-100%);
            transition: transform 0.4s cubic-bezier(0.77,0,0.18,1);
        }
        .login-btn svg, .login-btn span { position: relative; z-index: 1; }

        .login-btn--client {
            border-color: var(--green);
            color: var(--green);
        }
        .login-btn--client::before { background: var(--green); }
        .login-btn--client:hover { color: #111111; }
        .login-btn--client:hover::before { transform: translateX(0); }

        .login-btn--employe {
            border-color: rgba(245,240,232,0.2);
            color: #111111;
        }
        .login-btn--employe::before { background: rgba(245,240,232,0.08); }
        .login-btn--employe:hover {
            color: #111111;
            border-color: #111111;
        }
        .login-btn--employe:hover::before { transform: translateX(0); }

        .section-link {
            text-decoration: none;
            font-size: 0.68rem;
            font-weight: 500;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--green);
            border-bottom: 1px solid rgba(0,160,220,0.3);
            padding-bottom: 4px;
            transition: border-color 0.3s;
            white-space: nowrap;
            margin-bottom: 8px;
        }
        .section-link:hover { border-color: var(--green); }

        /* Service cards */
        .service-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1px;
            background: var(--bg-white);
        }

        .service-card {
            background: #FFFFFF;
            padding: 54px 44px;
            position: relative;
            overflow: hidden;
            transition: background 0.4s;
        }
        .service-card::before {
            content: '';
            position: absolute;
            bottom: 0; left: 0;
            width: 100%; height: 2px;
            background: var(--green);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.5s cubic-bezier(0.77,0,0.18,1);
        }
        .service-card:hover { background: var(--bg-light); }
        .service-card:hover::before { transform: scaleX(1); }

        .card-number {
            font-family: var(--font-serif); font-weight: 700;
            font-size: 4rem;
            font-weight: 300;
            color: rgba(0,160,220,0.08);
            line-height: 1;
            margin-bottom: 30px;
            transition: color 0.4s;
        }
        .service-card:hover .card-number { color: rgba(0,160,220,0.15); }

        .card-icon {
            width: 42px; height: 42px;
            margin-bottom: 24px;
            color: var(--green);
        }

        .service-card h4 {
            font-family: var(--font-serif); font-weight: 700;
            font-size: 1.5rem;
            font-weight: 400;
            letter-spacing: 0.03em;
            margin-bottom: 16px;
            color: #111111;
        }

        .service-card p {
            font-size: 0.8rem;
            line-height: 1.85;
            color: #111111;
        }

        /* ===================== SECTION — HIGHLIGHT ===================== */
        .section-highlight {
            padding: 0 0 140px;
        }

        .highlight-inner {
            background: var(--bg-white);
            border: 1px solid var(--border);
            box-shadow: 0 4px 40px rgba(0,0,0,0.06);
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        .highlight-visual {
            position: relative;
            min-height: 480px;
            background: var(--bg-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .highlight-visual::before {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 50% 50%, rgba(0,160,220,0.12) 0%, transparent 65%);
        }

        /* Big decorative car icon */
        .car-art {
            position: relative;
            z-index: 1;
            opacity: 0.35;
        }
        .car-art svg { width: 340px; height: auto; }

        .highlight-badge {
            position: absolute;
            top: 36px; right: 36px;
            width: 90px; height: 90px;
            border: 1px solid rgba(0,160,220,0.3);
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            animation: rotateBadge 15s linear infinite;
        }
        @keyframes rotateBadge {
            from { transform: rotate(0deg); }
            to   { transform: rotate(360deg); }
        }
        .badge-inner {
            animation: rotateBadge 15s linear infinite reverse;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .badge-inner span:first-child {
            font-family: var(--font-serif); font-weight: 700;
            font-size: 1.6rem;
            color: var(--green);
            line-height: 1;
        }
        .badge-inner span:last-child {
            font-size: 0.45rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: #111111;
        }

        .highlight-content {
            padding: 70px 60px;
            background: var(--bg-white);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .highlight-content .section-eyebrow { margin-bottom: 20px; }

        .highlight-content h3 {
            font-family: var(--font-serif); font-weight: 700;
            font-size: clamp(1.8rem, 3vw, 2.8rem);
            font-weight: 300;
            line-height: 1.2;
            margin-bottom: 24px;
        }
        .highlight-content h3 em { font-style: italic; color: var(--green); }

        .highlight-content p {
            font-size: 0.82rem;
            line-height: 1.9;
            color: #111111;
            margin-bottom: 44px;
        }

        .features-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 14px;
            margin-bottom: 44px;
        }
        .features-list li { color: #111111;
            display: flex;
            align-items: center;
            gap: 14px;
            font-size: 0.78rem;
            color: #111111;
            letter-spacing: 0.05em;
        }
        .features-list li::before {
            content: '';
            display: block;
            width: 20px; height: 1px;
            background: var(--green);
            flex-shrink: 0;
        }

        /* ===================== SECTION — FLEET ===================== */
        .section-fleet {
            padding: 0 0 140px;
        }

        .fleet-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 60px;
        }

        .fleet-card {
            position: relative;
            background: var(--bg-light);
            border: 1px solid rgba(0,160,220,0.08);
            overflow: hidden;
            transition: border-color 0.4s, transform 0.4s;
            cursor: pointer;
        }
        .fleet-card:hover {
            border-color: rgba(0,160,220,0.35);
            transform: translateY(-4px);
        }

        .fleet-card-visual { 
            height: 200px;
            background: var(--bg-light);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        .fleet-card-visual::after { display:none; }
        .fleet-car-icon { opacity: 0.4; color: var(--green); }

        .fleet-card-body { padding: 28px 32px 34px; }

        .fleet-tag {
            display: inline-block;
            font-size: 0.55rem;
            font-weight: 600;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: var(--green);
            border: 1px solid rgba(0,160,220,0.3);
            padding: 4px 10px;
            margin-bottom: 14px;
        }

        .fleet-card h4 { color: var(--green);
            font-family: var(--font-serif); font-size: 1.4rem; font-weight: 700; color: #111111;
            margin-bottom: 10px;
        }
        .fleet-card p { color: #111111;
            font-size: 0.75rem;
            color: #111111;
            line-height: 1.7;
        }

        .fleet-card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 32px;
            border-top: 1px solid rgba(0,122,61,0.12);
        }
        .fleet-price { color: var(--green);
            font-family: var(--font-serif); font-size: 0.9rem; font-weight: 700; color: var(--green);
        }
        .fleet-price strong { font-size: 1.5rem; }

        .fleet-cta {
            font-size: 0.6rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: #111111;
            text-decoration: none;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .fleet-card:hover .fleet-cta { color: var(--green); }

        /* ===================== SECTION — CTA BAND ===================== */
        .section-cta {
            padding: 0 0 140px;
        }

        .cta-band {
            background: var(--bg-dark);
            border: 1px solid rgba(0,160,220,0.2);
            padding: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 60px;
            position: relative;
            overflow: hidden;
        }
        .cta-band::before {
            content: '';
            position: absolute;
            top: -60%; right: -10%;
            width: 400px; height: 400px;
            border-radius: 50%;
            background: radial-gradient(circle at 30% 50%, rgba(0,122,61,0.15) 0%, transparent 60%), radial-gradient(circle at 70% 50%, rgba(0,160,220,0.1) 0%, transparent 60%);
        }

        .cta-text h3 {
            font-family: var(--font-serif); font-weight: 700;
            font-size: clamp(1.8rem, 3vw, 2.8rem);
            font-weight: 300;
            line-height: 1.15;
            margin-bottom: 14px;
        }
        .cta-text h3 em { font-style: italic; color: var(--green); }
        .cta-text p {
            font-size: 0.8rem;
            color: #111111;
            max-width: 440px;
            line-height: 1.8;
        }

        .cta-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 14px;
            flex-shrink: 0;
        }
        .cta-phone {
            font-family: var(--font-serif); font-weight: 700;
            font-size: 1.6rem;
            font-weight: 300;
            color: var(--green);
            letter-spacing: 0.05em;
        }
        .cta-phone-label {
            font-size: 0.6rem;
            letter-spacing: 0.25em;
            text-transform: uppercase;
            color: #111111;
        }

        /* ===================== FOOTER ===================== */
        footer {
            border-top: 1px solid rgba(0,160,220,0.1);
            padding: 60px 0 40px;
        }

        .footer-inner {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 60px;
            margin-bottom: 60px;
        }

        .footer-brand .logo-main { font-family:var(--font-serif); color: #111111 !important; font-weight: 700; font-size:2rem; font-weight:800; letter-spacing:0.25em; color: var(--red); display:block; line-height:1}
        .footer-brand p {
            font-size: 0.75rem;
            color: #111111;
            line-height: 1.8;
            max-width: 260px;
            margin-top: 16px;
        }

        .footer-col h5 {
            font-size: 0.62rem;
            font-weight: 600;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: var(--green);
            margin-bottom: 22px;
        }
        .footer-col ul { list-style: none; }
        .footer-col ul li { margin-bottom: 10px; }
        .footer-col ul li a {
            text-decoration: none;
            font-size: 0.78rem;
            color: #111111;
            transition: color 0.3s;
        }
        .footer-col ul li a:hover { color: #111111; }

        .footer-bottom {
            border-top: 1px solid rgba(26,35,64,0.07);
            padding-top: 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .footer-bottom p {
            font-size: 0.7rem;
            color: rgba(255,255,255,0.4);
            letter-spacing: 0.05em;
        }

        .footer-divider {
            width: 1px; height: 40px;
            background: linear-gradient(to bottom, transparent, rgba(0,160,220,0.3), transparent);
            margin: 0 20px;
        }

        /* ===================== ANIMATIONS ON SCROLL ===================== */
        .reveal {
            opacity: 0;
            transform: translateY(24px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }
        .reveal.visible {
            opacity: 1;
            transform: translateY(0);
        }
        .reveal-delay-1 { transition-delay: 0.1s; }
        .reveal-delay-2 { transition-delay: 0.2s; }
        .reveal-delay-3 { transition-delay: 0.3s; }

        /* ===================== RESPONSIVE ===================== */
        @media (max-width: 1024px) {
            .container { padding: 0 28px; }
            nav ul { gap: 24px; }
            .service-grid { grid-template-columns: 1fr; }
            .highlight-inner { grid-template-columns: 1fr; }
            .fleet-grid { grid-template-columns: 1fr 1fr; }
            .hero-stats { display: none; }
            .cta-band { flex-direction: column; padding: 50px 36px; }
            .cta-actions { align-items: flex-start; }
            .footer-inner { flex-wrap: wrap; gap: 40px; }
        }

        @media (max-width: 768px) {
            header { padding: 20px 0; }
            nav ul { gap: 16px; }
            .btn-nav { display: none; }
            .fleet-grid { grid-template-columns: 1fr; }
            .section-header { flex-direction: column; align-items: flex-start; gap: 24px; }
            .login-buttons { align-items: flex-start; flex-direction: row; flex-wrap: wrap; }
        }
    </style>
    <link rel="stylesheet" href="assets/theme.css">
</head>
<body>

<!-- ===================== HEADER ===================== -->
<header id="site-header">
    <div class="container">
        <a href="index.php" class="logo">
            <span class="logo-main">KAMK</span>
            <span class="logo-sub">Location de Véhicules</span>
        </a>
        <nav>
            <ul>
                <li><a href="index.php">Accueil</a></li>
                <li><a href="pages/location_vehicule.php">Véhicules</a></li>
                <li><a href="pages/tarifs.php">Tarifs</a></li>
                <li><a href="pages/contact.php">Contact</a></li>
                <li><a href="pages/tutoriel.php">Tutoriel</a></li>
                <li><a href="pages/chatbot.php" class="btn-questions"><span class="bq-dot"></span>Des questions ?</a></li>
                <li>
                    <button class="theme-toggle" id="themeToggle" title="Mode sombre">
                        <span class="theme-icon">🌙</span>
                    </button>
                </li>
                <li><a href="pages/connexion.php" class="btn-nav">Connexion</a></li>
            </ul>
        </nav>
    </div>
</header>

<!-- ===================== HERO ===================== -->
<section class="hero">
    <div class="hero-bg"></div>
    <div class="container">
        <div class="hero-content">

            <!-- Logo KAMK + étoile -->
            <div class="hero-logo-wrap">
                <!-- Étoile rouge djiboutienne (SVG) -->
                <svg class="hero-star" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <polygon points="40,4 49,30 76,30 54,47 62,74 40,57 18,74 26,47 4,30 31,30"
                             fill="#D7141A" opacity="0.92"/>
                </svg>
                <div class="hero-logo-text">
                    <span class="hero-logo-brand">KAMK</span>
                    <span class="hero-logo-sub">Location de Véhicules · Djibouti</span>
                </div>
            </div>

            <!-- Eyebrow -->
            <div class="hero-eyebrow">
                <span>Votre partenaire mobilité depuis 2020</span>
            </div>

            <!-- Titre -->
            <h2>La route vous<br>appartient,<br><em>à Djibouti</em></h2>

            <!-- Description -->
            <p class="hero-desc">
                18 véhicules premium, 5 régions couvertes, assistance 24h/7j.
                KAMK vous offre la liberté de conduire partout au pays.
            </p>

            <!-- Boutons -->
            <div class="hero-actions">
                <a href="pages/location_vehicule.php" class="btn-primary">
                    <span>Explorer la flotte</span>
                </a>
                <a href="pages/tarifs.php" class="btn-ghost">
                    Voir les tarifs
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </a>
            </div>
        </div>
    </div>

    <!-- Stats -->
    <div class="hero-stats">
        <div class="stat">
            <div class="stat-number">18</div>
            <div class="stat-label">Véhicules</div>
        </div>
        <div class="stat">
            <div class="stat-number">5</div>
            <div class="stat-label">Régions</div>
        </div>
        <div class="stat">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Assistance</div>
        </div>
        <div class="stat">
            <div class="stat-number">2020</div>
            <div class="stat-label">Fondée</div>
        </div>
    </div>

    <div class="scroll-indicator">
        <div class="scroll-line"></div>
        <span>Défiler</span>
    </div>
</section>

<!-- ===================== SERVICES ===================== -->
<section class="section-services">
    <div class="container">
        <div class="section-header reveal" style="justify-content:center;text-align:center;flex-direction:column;align-items:center;margin-bottom:60px;">
            <div class="section-eyebrow"><span>Ce que nous offrons</span></div>
            <h3 class="section-title">Une expérience<br><em>pensée pour vous</em></h3>
        </div>

        <!-- ===== CARTES ESPACES ===== -->
        <div class="reveal" style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-bottom:64px;">

            <!-- Espace Client -->
            <div style="border:2px solid var(--green);padding:36px 28px;text-align:center;background:var(--bg-white);position:relative;transition:transform 0.3s,box-shadow 0.3s;" onmouseover="this.style.transform='translateY(-6px)';this.style.boxShadow='0 16px 40px rgba(0,122,61,0.15)'" onmouseout="this.style.transform='none';this.style.boxShadow='none'">
                <div style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,var(--green),var(--green-light,#00A052));display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;">👤</div>
                <h4 style="font-family:var(--font-serif);font-size:1.25rem;font-weight:700;color:var(--green);margin-bottom:10px;">Espace Client</h4>
                <p style="font-size:0.75rem;line-height:1.85;color:#111111;margin-bottom:24px;">Consultez votre historique de locations, gérez vos réservations en cours, téléchargez vos factures et suivez l'état de vos contrats en temps réel.</p>
                <div style="display:flex;flex-direction:column;gap:6px;margin-bottom:24px;text-align:left;">
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--green);font-weight:700;">✓</span> Réserver un véhicule</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--green);font-weight:700;">✓</span> Suivre mes contrats</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--green);font-weight:700;">✓</span> Télécharger mes factures</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--green);font-weight:700;">✓</span> Gérer mon profil</div>
                </div>
                <a href="pages/dashboard_client.php" style="display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--green);color:#fff;text-decoration:none;font-family:var(--font-sans);font-size:0.62rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;width:100%;justify-content:center;transition:background 0.2s;" onmouseover="this.style.background='var(--green-dim,#005C2D)'" onmouseout="this.style.background='var(--green)'">
                    Accéder →
                </a>
            </div>

            <!-- Espace Employé -->
            <div style="border:2px solid var(--blue);padding:36px 28px;text-align:center;background:var(--bg-white);position:relative;transition:transform 0.3s,box-shadow 0.3s;transform:translateY(-8px);" onmouseover="this.style.transform='translateY(-14px)';this.style.boxShadow='0 16px 40px rgba(0,160,220,0.18)'" onmouseout="this.style.transform='translateY(-8px)';this.style.boxShadow='none'">
                <div style="position:absolute;top:-14px;left:50%;transform:translateX(-50%);background:var(--blue);color:#fff;font-size:0.5rem;font-weight:700;letter-spacing:0.2em;text-transform:uppercase;padding:5px 14px;white-space:nowrap;">Personnel KAMK</div>
                <div style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,var(--blue),var(--blue-dim,#007BAD));display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;">💼</div>
                <h4 style="font-family:var(--font-serif);font-size:1.25rem;font-weight:700;color:var(--blue);margin-bottom:10px;">Espace Employé</h4>
                <p style="font-size:0.75rem;line-height:1.85;color:#111111;margin-bottom:24px;">Gérez les réservations clients, validez les contrats, suivez l'état du parc automobile et coordonnez les livraisons selon votre rôle dans l'agence.</p>
                <div style="display:flex;flex-direction:column;gap:6px;margin-bottom:24px;text-align:left;">
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--blue);font-weight:700;">✓</span> Gérer les locations</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--blue);font-weight:700;">✓</span> Valider les contrats</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--blue);font-weight:700;">✓</span> Suivi maintenance</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--blue);font-weight:700;">✓</span> Planning livraisons</div>
                </div>
                <a href="pages/dashboard_employe.php" style="display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--blue);color:#fff;text-decoration:none;font-family:var(--font-sans);font-size:0.62rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;width:100%;justify-content:center;transition:background 0.2s;" onmouseover="this.style.background='var(--blue-dim,#007BAD)'" onmouseout="this.style.background='var(--blue)'">
                    Accéder →
                </a>
            </div>

            <!-- Espace Admin -->
            <div style="border:2px solid var(--red);padding:36px 28px;text-align:center;background:var(--bg-white);position:relative;transition:transform 0.3s,box-shadow 0.3s;" onmouseover="this.style.transform='translateY(-6px)';this.style.boxShadow='0 16px 40px rgba(215,20,26,0.13)'" onmouseout="this.style.transform='none';this.style.boxShadow='none'">
                <div style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,var(--red),#B71C1C);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:1.6rem;">👑</div>
                <h4 style="font-family:var(--font-serif);font-size:1.25rem;font-weight:700;color:var(--red);margin-bottom:10px;">Espace Admin</h4>
                <p style="font-size:0.75rem;line-height:1.85;color:#111111;margin-bottom:24px;">Accès complet à la gestion de l'agence : supervision des employés, statistiques globales, configuration du système, gestion de la flotte et rapports financiers.</p>
                <div style="display:flex;flex-direction:column;gap:6px;margin-bottom:24px;text-align:left;">
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--red);font-weight:700;">✓</span> Gestion des employés</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--red);font-weight:700;">✓</span> Statistiques & rapports</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--red);font-weight:700;">✓</span> Configuration système</div>
                    <div style="font-size:0.67rem;color:#111111;display:flex;gap:8px;align-items:center;"><span style="color:var(--red);font-weight:700;">✓</span> Gestion flotte complète</div>
                </div>
                <a href="pages/dashboard_admin.php" style="display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--red);color:#fff;text-decoration:none;font-family:var(--font-sans);font-size:0.62rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;width:100%;justify-content:center;transition:background 0.2s;" onmouseover="this.style.background='#B71C1C'" onmouseout="this.style.background='var(--red)'">
                    Accéder →
                </a>
            </div>

        </div>

        <div class="service-grid">
            <div class="service-card reveal reveal-delay-1">
                <div class="card-number">01</div>
                <svg class="card-icon" viewBox="0 0 42 42" fill="none" stroke="currentColor" stroke-width="1.2">
                    <rect x="4" y="14" width="34" height="18" rx="3"/>
                    <path d="M10 14l4-7h14l4 7"/>
                    <circle cx="12" cy="32" r="3"/><circle cx="30" cy="32" r="3"/>
                </svg>
                <h4>Véhicules Premium</h4>
                <p>Une flotte soigneusement sélectionnée : berlines, SUV, citadines. Chaque véhicule est entretenu aux plus hauts standards pour garantir votre confort.</p>
            </div>
            <div class="service-card reveal reveal-delay-2">
                <div class="card-number">02</div>
                <svg class="card-icon" viewBox="0 0 42 42" fill="none" stroke="currentColor" stroke-width="1.2">
                    <rect x="6" y="6" width="30" height="30" rx="2"/>
                    <path d="M6 16h30M16 6v30M26 6v30"/>
                </svg>
                <h4>Réservation Instantanée</h4>
                <p>Notre plateforme intuitive vous permet de réserver votre véhicule en quelques secondes, à toute heure, depuis n'importe quel appareil.</p>
            </div>
            <div class="service-card reveal reveal-delay-3">
                <div class="card-number">03</div>
                <svg class="card-icon" viewBox="0 0 42 42" fill="none" stroke="currentColor" stroke-width="1.2">
                    <circle cx="21" cy="21" r="15"/>
                    <path d="M21 12v9l6 4"/>
                </svg>
                <h4>Assistance 24h/24</h4>
                <p>Notre équipe dédiée est disponible à toute heure pour vous accompagner, répondre à vos questions et intervenir en cas de besoin.</p>
            </div>
        </div>
    </div>
</section>

<!-- ===================== HIGHLIGHT ===================== -->
<section class="section-highlight">
    <div class="container">
        <div class="highlight-inner reveal">
            <div class="highlight-visual">
                <!-- Motif grille décoratif -->
                <div style="position:absolute;inset:0;background-image:linear-gradient(rgba(255,255,255,0.07) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,0.07) 1px,transparent 1px);background-size:40px 40px;"></div>

                <!-- Étoile rouge décorative drapeau -->
                <div style="position:absolute;top:24px;right:24px;opacity:0.25;font-size:5rem;color:#D7141A;">★</div>
                <div style="position:absolute;bottom:24px;left:24px;opacity:0.15;font-size:3rem;color:#FFFFFF;">★</div>

                <!-- Contenu principal -->
                <div style="position:relative;z-index:2;text-align:center;padding:40px;">
                    <!-- Badge agence -->
                    <div style="display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,0.15);border:1px solid rgba(255,255,255,0.3);padding:6px 16px;margin-bottom:28px;">
                        <span style="width:8px;height:8px;border-radius:50%;background:#D7141A;display:inline-block;"></span>
                        <span style="font-size:0.6rem;font-weight:700;letter-spacing:0.3em;text-transform:uppercase;color:rgba(255,255,255,0.9);">Depuis 2020 · Djibouti</span>
                    </div>

                    <!-- Nom agence -->
                    <div style="font-family:var(--font-serif);font-size:clamp(2.5rem,5vw,4.5rem);font-weight:800;color:#FFFFFF;letter-spacing:0.08em;line-height:1;margin-bottom:12px;">
                        AGENCE
                    </div>
                    <div style="font-family:var(--font-serif);font-size:clamp(3rem,6vw,5.5rem);font-weight:800;color:#FFFFFF;letter-spacing:0.15em;line-height:1;margin-bottom:20px;text-shadow:0 4px 24px rgba(0,0,0,0.3);">
                        KAMK
                    </div>

                    <!-- Sous-titre -->
                    <div style="font-size:0.62rem;font-weight:600;letter-spacing:0.4em;text-transform:uppercase;color:rgba(255,255,255,0.75);margin-bottom:32px;">
                        Location de Véhicules · Djibouti
                    </div>

                    <!-- 3 stats -->
                    <div style="display:flex;gap:0;border-top:1px solid rgba(255,255,255,0.2);padding-top:24px;">
                        <div style="flex:1;text-align:center;padding:0 12px;border-right:1px solid rgba(255,255,255,0.2);">
                            <div style="font-family:var(--font-serif);font-size:1.8rem;font-weight:700;color:#FFFFFF;">18</div>
                            <div style="font-size:0.5rem;letter-spacing:0.2em;text-transform:uppercase;color:rgba(255,255,255,0.65);margin-top:2px;">Véhicules</div>
                        </div>
                        <div style="flex:1;text-align:center;padding:0 12px;border-right:1px solid rgba(255,255,255,0.2);">
                            <div style="font-family:var(--font-serif);font-size:1.8rem;font-weight:700;color:#FFFFFF;">5</div>
                            <div style="font-size:0.5rem;letter-spacing:0.2em;text-transform:uppercase;color:rgba(255,255,255,0.65);margin-top:2px;">Régions</div>
                        </div>
                        <div style="flex:1;text-align:center;padding:0 12px;">
                            <div style="font-family:var(--font-serif);font-size:1.8rem;font-weight:700;color:#FFFFFF;">24/7</div>
                            <div style="font-size:0.5rem;letter-spacing:0.2em;text-transform:uppercase;color:rgba(255,255,255,0.65);margin-top:2px;">Support</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="highlight-content">
                <div class="section-eyebrow"><span>Pourquoi KAMK ?</span></div>
                <h3 style="color:var(--green);">La location<br><em style="color:var(--blue);">réinventée</em></h3>
                <p style="color:#111111;">Chez KAMK, nous croyons que louer un véhicule devrait être aussi agréable que de le conduire. Chaque détail de notre service est conçu pour dépasser vos attentes.</p>
                <ul class="features-list">
                    <li>Kilométrage illimité sur toutes les offres</li>
                    <li>Assurance tous risques incluse</li>
                    <li>Livraison à domicile disponible</li>
                    <li>Annulation gratuite jusqu'à 24h avant</li>
                    <li>Programme de fidélité exclusif</li>
                </ul>
                <a href="pages/location_vehicule.php" class="btn-primary">
                    <span>Réserver maintenant</span>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ===================== FLEET ===================== -->
<section class="section-fleet">
    <div class="container">
        <div class="section-header reveal">
            <div>
                <div class="section-eyebrow"><span>Notre flotte</span></div>
                <h3 class="section-title">Des véhicules pour<br><em>chaque occasion</em></h3>
            </div>
        </div>

        <div class="fleet-grid">
            <div class="fleet-card reveal reveal-delay-1">
                <div class="fleet-card-visual" style="padding:0;overflow:hidden;">
                    <img src="images/fleet_citadine.png" alt="Citadine & Berline" style="width:100%;height:100%;object-fit:cover;display:block;transition:transform 0.5s;">
                </div>
                <div class="fleet-card-body">
                    <span class="fleet-tag">Personnel</span>
                    <h4>Citadine & Berline</h4>
                    <p>Économiques et agiles, parfaites pour vos déplacements quotidiens en ville.</p>
                </div>
                <div class="fleet-card-footer">
                    <div class="fleet-price">À partir de <strong>29€</strong><span style="font-size:0.75rem;color:#111111">/jour</span></div>
                    <a href="pages/location_vehicule.php" class="fleet-cta">
                        Voir →
                    </a>
                </div>
            </div>

            <div class="fleet-card reveal reveal-delay-2">
                <div class="fleet-card-visual" style="padding:0;overflow:hidden;">
                    <img src="images/fleet_familiale.png" alt="Voiture Familiale" style="width:100%;height:100%;object-fit:cover;display:block;transition:transform 0.5s;">
                </div>
                <div class="fleet-card-body">
                    <span class="fleet-tag">Familiale</span>
                    <h4>Voiture Familiale</h4>
                    <p>Spacieux et confortable, idéal pour les déplacements en famille jusqu'à 9 personnes.</p>
                </div>
                <div class="fleet-card-footer">
                    <div class="fleet-price">À partir de <strong>55€</strong><span style="font-size:0.75rem;color:#111111">/jour</span></div>
                    <a href="pages/location_vehicule.php" class="fleet-cta">
                        Voir →
                    </a>
                </div>
            </div>

            <div class="fleet-card reveal reveal-delay-3">
                <div class="fleet-card-visual" style="padding:0;overflow:hidden;">
                    <img src="images/fleet_entreprise.png" alt="Véhicule Entreprise" style="width:100%;height:100%;object-fit:cover;display:block;transition:transform 0.5s;">
                </div>
                <div class="fleet-card-body">
                    <span class="fleet-tag">Entreprise</span>
                    <h4>Entreprise & 4x4</h4>
                    <p>SUV et 4x4 robustes pour les terrains difficiles et missions professionnelles.</p>
                </div>
                <div class="fleet-card-footer">
                    <div class="fleet-price">À partir de <strong>120€</strong><span style="font-size:0.75rem;color:#111111">/jour</span></div>
                    <a href="pages/location_vehicule.php" class="fleet-cta">
                        Voir →
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===================== ZONES DJIBOUTI ===================== -->
<section class="section-zones">
    <div class="container">
        <div class="section-header reveal">
            <div>
                <div class="section-eyebrow"><span>Couverture nationale</span></div>
                <h3 class="section-title">Disponible dans les<br><em>5 régions</em> de Djibouti</h3>
            </div>
            <a href="pages/location_vehicule.php" class="section-link">Voir tous les véhicules →</a>
        </div>

        <div class="zones-grid reveal">

            <!-- Djibouti-Ville — grande carte principale -->
            <a href="pages/location_vehicule.php?zone=djibouti" class="zone-card zone-card--main">
                <div class="zone-img" style="background-image:url('img_obock.png');background-position:center 40%"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Djibouti-Ville</span>
                    <span class="zone-sub">Siège de l'agence KAMK</span>
                    <span class="zone-count">🏢 Agence principale · 18 véhicules</span>
                </div>
                <div class="zone-badge">Siège</div>
            </a>

            <!-- Région Dikhil -->
            <a href="pages/location_vehicule.php?zone=dikhil" class="zone-card">
                <div class="zone-img" style="background-image:url('img_dikhil.png');background-position:center 30%"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Dikhil</span>
                    <span class="zone-count">Région de l'Unité</span>
                </div>
            </a>

            <!-- Région Tadjourah -->
            <a href="pages/location_vehicule.php?zone=tadjourah" class="zone-card">
                <div class="zone-img" style="background-image:url('img_tadjourah.png');background-position:center 20%"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Tadjourah</span>
                    <span class="zone-count">Région de la Mer Rouge</span>
                </div>
            </a>

            <!-- Région Ali Sabieh -->
            <a href="pages/location_vehicule.php?zone=alisabieh" class="zone-card">
                <div class="zone-img" style="background-image:url('img_alisabieh.png');background-position:center 30%"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Ali Sabieh</span>
                    <span class="zone-count">Région du Sud</span>
                </div>
            </a>

            <!-- Région Obock -->
            <a href="pages/location_vehicule.php?zone=obock" class="zone-card">
                <div class="zone-img" style="background-image:url('img_obock.png')"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Obock</span>
                    <span class="zone-count">Région du Nord</span>
                </div>
            </a>

            <!-- Région Arta -->
            <a href="pages/location_vehicule.php?zone=arta" class="zone-card">
                <div class="zone-img" style="background-image:url('img_arta.png')"></div>
                <div class="zone-overlay"></div>
                <div class="zone-content">
                    <div class="zone-dot"></div>
                    <span class="zone-name">Arta</span>
                    <span class="zone-count">Région Centrale</span>
                </div>
            </a>

        </div>
    </div>
</section>

<!-- ===================== TYPES VEHICULES ===================== -->
<section class="section-types">
    <div class="container">
        <div class="section-header reveal">
            <div>
                <div class="section-eyebrow"><span>Par catégorie</span></div>
                <h3 class="section-title">Des véhicules adaptés<br>à <em>vos besoins</em></h3>
            </div>
        </div>

        <div class="types-grid reveal">
            <a href="pages/location_vehicule.php?cat=personnel" class="type-card">
                <div class="type-visual">
                    <svg viewBox="0 0 320 150" fill="none" width="160"><path d="M18 108 L52 66 L96 46 L224 46 L268 66 L302 108 L302 128 L18 128 Z" stroke="currentColor" stroke-width="1.5"/><path d="M52 66 L82 36 L238 36 L268 66" stroke="currentColor" stroke-width="1" opacity="0.5"/><circle cx="72" cy="128" r="20" stroke="currentColor" stroke-width="1.5"/><circle cx="248" cy="128" r="20" stroke="currentColor" stroke-width="1.5"/></svg>
                </div>
                <div class="type-info">
                    <span class="type-name">Citadine &<br>Berline</span>
                    <span class="type-count">7 modèles</span>
                </div>
                <div class="type-arrow">→</div>
            </a>

            <a href="pages/location_vehicule.php?cat=familiale" class="type-card">
                <div class="type-visual">
                    <svg viewBox="0 0 360 160" fill="none" width="170"><path d="M10 115 L45 62 L95 40 L265 40 L315 65 L350 115 L350 138 L10 138 Z" stroke="currentColor" stroke-width="1.5"/><path d="M45 62 L75 28 L270 28 L315 65" stroke="currentColor" stroke-width="1" opacity="0.5"/><circle cx="75" cy="138" r="24" stroke="currentColor" stroke-width="1.5"/><circle cx="275" cy="138" r="24" stroke="currentColor" stroke-width="1.5"/><line x1="185" y1="28" x2="185" y2="62" stroke="currentColor" stroke-width="0.8" opacity="0.3"/></svg>
                </div>
                <div class="type-info">
                    <span class="type-name">Familiale &<br>Monospace</span>
                    <span class="type-count">4 modèles</span>
                </div>
                <div class="type-arrow">→</div>
            </a>

            <a href="pages/location_vehicule.php?cat=entreprise" class="type-card type-card--featured">
                <div class="type-visual">
                    <svg viewBox="0 0 340 160" fill="none" width="170"><path d="M15 115 L50 65 L95 42 L245 42 L290 68 L325 115 L325 138 L15 138 Z" stroke="currentColor" stroke-width="1.5"/><path d="M50 65 L80 32 L260 32 L290 68" stroke="currentColor" stroke-width="1" opacity="0.5"/><circle cx="78" cy="138" r="24" stroke="currentColor" stroke-width="1.5"/><circle cx="262" cy="138" r="24" stroke="currentColor" stroke-width="1.5"/><path d="M140 42 L160 68 L180 42" stroke="currentColor" stroke-width="0.8" opacity="0.3"/></svg>
                </div>
                <div class="type-info">
                    <span class="type-name">SUV &<br>Tout-terrain</span>
                    <span class="type-count">7 modèles</span>
                </div>
                <div class="type-arrow">→</div>
            </a>

            <a href="pages/location_vehicule.php?cat=minibus" class="type-card">
                <div class="type-visual" style="height:80px;overflow:hidden;border-radius:2px;">
                    <img src="images/fleet_minibus.png" alt="Minibus & Navette" style="width:100%;height:100%;object-fit:cover;opacity:0.85;transition:opacity 0.3s;">
                </div>
                <div class="type-info">
                    <span class="type-name">Minibus &<br>Navette</span>
                    <span class="type-count">2 modèles</span>
                </div>
                <div class="type-arrow">→</div>
            </a>
        </div>
    </div>
</section>

<style>
/* ===== ZONES ===== */
.section-zones { padding: 0 0 120px; }

.zones-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: 260px 200px;
    gap: 10px;
}

.zone-card {
    position: relative;
    overflow: hidden;
    text-decoration: none;
    cursor: pointer;
}
/* Djibouti-Ville — grande carte à gauche sur 2 lignes */
.zone-card--main {
    grid-column: span 1;
    grid-row: span 2;
}

.zone-img {
    position: absolute; inset: 0;
    background-size: cover;
    background-position: center;
    transition: transform 0.6s ease;
    filter: brightness(0.45) saturate(0.6);
}
.zone-card:hover .zone-img { transform: scale(1.06); filter: brightness(0.6) saturate(0.8); }

.zone-overlay {
    position: absolute; inset: 0;
    background: linear-gradient(to top, rgba(26,35,64,0.92) 0%, rgba(26,35,64,0.2) 60%, transparent 100%);
}

.zone-content {
    position: absolute;
    bottom: 20px; left: 20px; right: 20px;
    display: flex; flex-direction: column; gap: 4px;
}

.zone-dot {
    width: 7px; height: 7px; border-radius: 50%;
    background: var(--green);
    box-shadow: 0 0 8px var(--accent);
    margin-bottom: 4px;
    animation: gpsBlink 2s ease infinite;
}
@keyframes gpsBlink { 0%,100%{opacity:1} 50%{opacity:0.4} }

.zone-name { color: #ffffff; color: #111111 !important;
    font-family: var(--font-serif); font-weight: 700;
    font-size: 1.3rem;
    font-weight: 400;
    color: #111111;
    line-height: 1.1;
}
.zone-card--main .zone-name { color: #ffffff; color: #111111 !important; font-size: 2rem; }

.zone-sub {
    font-size: 0.65rem;
    color: var(--green);
    letter-spacing: 0.05em;
    margin-bottom: 2px;
}

.zone-count {
    font-size: 0.58rem;
    font-weight: 500;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    color: rgba(255,255,255,0.8);
}

.zone-badge {
    position: absolute; top: 16px; right: 16px;
    font-size: 0.52rem; font-weight: 600;
    letter-spacing: 0.25em; text-transform: uppercase;
    color: var(--green); border: 1px solid rgba(0,160,220,0.35);
    padding: 4px 10px;
    background: var(--bg-dark);
    backdrop-filter: blur(6px);
}

/* hover border accent */
.zone-card::after {
    content: '';
    position: absolute; inset: 0;
    border: 1px solid rgba(0,150,60,0);
    transition: border-color 0.3s;
    pointer-events: none;
}
.zone-card:hover::after { border-color: rgba(0,160,220,0.45); }

@media(max-width:900px) {
    .zones-grid { grid-template-columns:repeat(2,1fr); grid-template-rows:auto; }
    .zone-card--main { grid-column:span 2; height:220px; grid-row:span 1; }
}
@media(max-width:560px) {
    .zones-grid { grid-template-columns:1fr; }
    .zone-card--main { grid-column:span 1; height:200px; }
}
.section-types { padding: 0 0 120px; }

.types-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1px;
    background: rgba(0,160,220,0.08);
}

.type-card {
    background: #FFFFFF;
    padding: 36px 28px 28px;
    text-decoration: none;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    position: relative;
    overflow: hidden;
    transition: background 0.3s;
}
.type-card:hover { background: var(--bg-light); }
.type-card--featured { background: var(--bg-light); }
.type-card--featured::before {
    content: 'Populaire';
    position: absolute; top: 14px; right: 14px;
    font-size: 0.52rem; font-weight: 600;
    letter-spacing: 0.2em; text-transform: uppercase;
    color: var(--green); border: 1px solid rgba(0,160,220,0.3);
    padding: 3px 8px;
}

.type-visual {
    color: var(--green);
    opacity: 0.5;
    transition: opacity 0.3s, transform 0.4s;
    display: flex; align-items: center; justify-content: center;
    height: 80px;
}
.type-card:hover .type-visual { opacity: 0.8; transform: scale(1.05); }

.type-info {
    display: flex; flex-direction: column;
    align-items: center; gap: 6px; text-align: center;
}
.type-name {
    font-family: var(--font-serif); font-weight: 700;
    font-size: 1.1rem; font-weight: 400;
    color: #111111; line-height: 1.2;
}
.type-count {
    font-size: 0.58rem; font-weight: 500;
    letter-spacing: 0.2em; text-transform: uppercase;
    color: #111111;
}

.type-arrow {
    font-size: 1rem; color: var(--green);
    opacity: 0;
    transform: translateX(-8px);
    transition: opacity 0.3s, transform 0.3s;
}
.type-card:hover .type-arrow { opacity: 1; transform: translateX(0); }

/* Bottom accent line */
.type-card::after {
    content: '';
    position: absolute; bottom: 0; left: 0;
    width: 100%; height: 2px;
    background: var(--green);
    transform: scaleX(0); transform-origin: left;
    transition: transform 0.4s cubic-bezier(0.77,0,0.18,1);
}
.type-card:hover::after, .type-card--featured::after { transform: scaleX(1); }

@media(max-width:900px) {
    .zones-grid { grid-template-columns:repeat(2,1fr); grid-template-rows:auto; }
    .zone-card:nth-child(1) { grid-column:span 2; height:200px; }
    .types-grid { grid-template-columns:repeat(2,1fr); }
}
@media(max-width:560px) {
    .zones-grid { grid-template-columns:1fr; }
    .zone-card:nth-child(1) { grid-column:span 1; }
    .types-grid { grid-template-columns:1fr 1fr; }
}
</style>

<!-- ===================== CTA BAND ===================== -->

<!-- ===== SECTION MÉTÉO DJIBOUTI ===== -->
<section class="section-meteo reveal" style="padding:80px 0;background:var(--bg-white);">
    <div class="container">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:60px;align-items:center;">

            <!-- Texte gauche -->
            <div>
                <div class="section-eyebrow"><span>Conditions actuelles</span></div>
                <h3 class="section-title" style="margin-bottom:16px;">Météo à<br><em>Djibouti</em></h3>
                <p style="font-size:0.82rem;line-height:1.9;color:#111111;margin-bottom:28px;">
                    Consultez les conditions météorologiques en temps réel avant de choisir votre véhicule. Un 4x4 pour les terrains difficiles après la pluie, une citadine pour les belles journées en ville.
                </p>
                <div style="display:flex;gap:12px;flex-wrap:wrap;">
                    <a href="pages/location_vehicule.php?cat=entreprise" style="display:inline-flex;align-items:center;gap:6px;padding:10px 20px;background:var(--green);color:#fff;text-decoration:none;font-size:0.65rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;">
                        🏔️ Voir les 4x4
                    </a>
                    <a href="pages/location_vehicule.php?cat=personnel" style="display:inline-flex;align-items:center;gap:6px;padding:10px 20px;border:1px solid var(--border);color:var(--green);text-decoration:none;font-size:0.65rem;font-weight:700;letter-spacing:0.15em;text-transform:uppercase;">
                        🚗 Voir citadines
                    </a>
                </div>
            </div>

            <!-- Widget météo droite -->
            <div id="meteo-widget" style="background:linear-gradient(135deg,var(--bg-dark,#0D1B2A),#152234);border-radius:4px;padding:36px;color:#fff;min-height:220px;display:flex;align-items:center;justify-content:center;">
                <div id="meteo-loading" style="text-align:center;opacity:0.5;">
                    <div style="font-size:2rem;margin-bottom:8px;">⏳</div>
                    <div style="font-size:0.7rem;letter-spacing:0.2em;text-transform:uppercase;">Chargement météo...</div>
                </div>
                <div id="meteo-content" style="display:none;width:100%;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:24px;">
                        <div>
                            <div style="font-size:0.55rem;letter-spacing:0.3em;text-transform:uppercase;color:rgba(255,255,255,0.5);margin-bottom:4px;">Djibouti-Ville</div>
                            <div id="meteo-temp" style="font-family:var(--font-serif);font-size:4rem;font-weight:700;line-height:1;color:#fff;"></div>
                            <div id="meteo-desc" style="font-size:0.72rem;color:rgba(255,255,255,0.7);margin-top:4px;text-transform:capitalize;"></div>
                        </div>
                        <div id="meteo-icon" style="font-size:4rem;"></div>
                    </div>
                    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:1px;background:rgba(255,255,255,0.08);">
                        <div style="background:rgba(255,255,255,0.04);padding:12px;text-align:center;">
                            <div style="font-size:1rem;margin-bottom:4px;">💧</div>
                            <div id="meteo-hum" style="font-size:0.8rem;font-weight:600;color:#fff;"></div>
                            <div style="font-size:0.48rem;letter-spacing:0.15em;text-transform:uppercase;color:rgba(255,255,255,0.4);margin-top:2px;">Humidité</div>
                        </div>
                        <div style="background:rgba(255,255,255,0.04);padding:12px;text-align:center;">
                            <div style="font-size:1rem;margin-bottom:4px;">💨</div>
                            <div id="meteo-wind" style="font-size:0.8rem;font-weight:600;color:#fff;"></div>
                            <div style="font-size:0.48rem;letter-spacing:0.15em;text-transform:uppercase;color:rgba(255,255,255,0.4);margin-top:2px;">Vent</div>
                        </div>
                        <div style="background:rgba(255,255,255,0.04);padding:12px;text-align:center;">
                            <div style="font-size:1rem;margin-bottom:4px;">🌡️</div>
                            <div id="meteo-feels" style="font-size:0.8rem;font-weight:600;color:#fff;"></div>
                            <div style="font-size:0.48rem;letter-spacing:0.15em;text-transform:uppercase;color:rgba(255,255,255,0.4);margin-top:2px;">Ressenti</div>
                        </div>
                    </div>
                    <div id="meteo-conseil" style="margin-top:16px;padding:12px 16px;background:rgba(0,122,61,0.15);border-left:3px solid var(--green);font-size:0.68rem;color:rgba(255,255,255,0.85);line-height:1.6;"></div>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- ===== SECTION AVIS CLIENTS ===== -->
<section class="section-avis reveal" style="padding:100px 0;background:var(--bg-light,#F0F2F5);">
    <div class="container">
        <div class="section-header reveal" style="display:flex;justify-content:space-between;align-items:flex-end;margin-bottom:56px;">
            <div>
                <div class="section-eyebrow"><span>Témoignages</span></div>
                <h3 class="section-title">Ce que disent<br><em>nos clients</em></h3>
            </div>
            <div style="display:flex;align-items:center;gap:8px;">
                <div style="display:flex;gap:3px;">
                    <span style="color:#F5A623;font-size:1.1rem;">★★★★★</span>
                </div>
                <span style="font-family:var(--font-serif);font-size:1.8rem;font-weight:700;color:var(--green);">4.9</span>
                <span style="font-size:0.62rem;color:#111111;letter-spacing:0.1em;">/5 · 128 avis</span>
            </div>
        </div>

        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:24px;" class="avis-grid">

            <!-- Avis 1 -->
            <div class="avis-card" style="background:var(--bg-white,#fff);padding:32px;border:1px solid var(--border,#E2E5EA);border-top:4px solid var(--green);position:relative;">
                <div style="display:flex;gap:3px;margin-bottom:16px;">
                    <span style="color:#F5A623;">★★★★★</span>
                </div>
                <p style="font-size:0.78rem;line-height:1.85;color:#111111;margin-bottom:20px;font-style:italic;">
                    "Service impeccable ! J'ai loué un Toyota Hilux pour une mission à Tadjourah. Livraison ponctuelle, véhicule en parfait état. Je recommande vivement KAMK à tous mes collègues."
                </p>
                <div style="display:flex;align-items:center;gap:12px;border-top:1px solid var(--border,#E2E5EA);padding-top:16px;">
                    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--green),var(--blue));display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:0.9rem;flex-shrink:0;">AH</div>
                    <div>
                        <div style="font-size:0.72rem;font-weight:700;color:#111111;">Ahmed Hassan</div>
                        <div style="font-size:0.6rem;color:#111111;">Toyota Hilux · Mission Tadjourah</div>
                    </div>
                    <div style="margin-left:auto;font-size:0.55rem;color:#111111;">il y a 2 jours</div>
                </div>
            </div>

            <!-- Avis 2 — Featured -->
            <div class="avis-card" style="background:var(--bg-dark,#0D1B2A);padding:32px;border:1px solid rgba(255,255,255,0.08);border-top:4px solid var(--blue);position:relative;transform:translateY(-12px);">
                <div style="position:absolute;top:-12px;left:50%;transform:translateX(-50%);background:var(--blue);color:#fff;font-size:0.5rem;font-weight:700;letter-spacing:0.2em;text-transform:uppercase;padding:4px 12px;">⭐ Coup de coeur</div>
                <div style="display:flex;gap:3px;margin-bottom:16px;">
                    <span style="color:#F5A623;">★★★★★</span>
                </div>
                <p style="font-size:0.78rem;line-height:1.85;color:rgba(255,255,255,0.85);margin-bottom:20px;font-style:italic;">
                    "Incroyable ! L'application mobile pour déverrouiller le véhicule est une vraie innovation. En tant qu'expatriée, j'apprécie la modernité et le professionnalisme de KAMK. La meilleure agence de location à Djibouti !"
                </p>
                <div style="display:flex;align-items:center;gap:12px;border-top:1px solid rgba(255,255,255,0.1);padding-top:16px;">
                    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--blue),#005F8A);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:0.9rem;flex-shrink:0;">SM</div>
                    <div>
                        <div style="font-size:0.72rem;font-weight:700;color:#FFFFFF;">Sophie Martin</div>
                        <div style="font-size:0.6rem;color:rgba(255,255,255,0.5);">VW Jetta · Déverrouillage App</div>
                    </div>
                    <div style="margin-left:auto;font-size:0.55rem;color:rgba(255,255,255,0.4);">il y a 5 jours</div>
                </div>
            </div>

            <!-- Avis 3 -->
            <div class="avis-card" style="background:var(--bg-white,#fff);padding:32px;border:1px solid var(--border,#E2E5EA);border-top:4px solid var(--red);position:relative;">
                <div style="display:flex;gap:3px;margin-bottom:16px;">
                    <span style="color:#F5A623;">★★★★</span><span style="color:#ddd;">★</span>
                </div>
                <p style="font-size:0.78rem;line-height:1.85;color:#111111;margin-bottom:20px;font-style:italic;">
                    "Très bonne expérience globale. Le Land Cruiser était parfait pour notre safari autour du Lac Assal. Le support client 24h/24 a été très utile quand on a eu une question en route."
                </p>
                <div style="display:flex;align-items:center;gap:12px;border-top:1px solid var(--border,#E2E5EA);padding-top:16px;">
                    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--red),#B71C1C);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:0.9rem;flex-shrink:0;">MO</div>
                    <div>
                        <div style="font-size:0.72rem;font-weight:700;color:#111111;">Mohamed Omar</div>
                        <div style="font-size:0.6rem;color:#111111;">Land Cruiser · Lac Assal</div>
                    </div>
                    <div style="margin-left:auto;font-size:0.55rem;color:#111111;">il y a 1 semaine</div>
                </div>
            </div>

        </div>

        <!-- Note globale -->
        <div style="margin-top:48px;text-align:center;">
            <div style="display:inline-flex;align-items:center;gap:24px;padding:20px 40px;background:var(--bg-white,#fff);border:1px solid var(--border,#E2E5EA);">
                <div style="text-align:center;">
                    <div style="font-family:var(--font-serif);font-size:2.5rem;font-weight:700;color:var(--green);line-height:1;">4.9</div>
                    <div style="display:flex;gap:2px;justify-content:center;margin:4px 0;"><span style="color:#F5A623;font-size:0.9rem;">★★★★★</span></div>
                    <div style="font-size:0.55rem;letter-spacing:0.15em;text-transform:uppercase;color:#666;">Note globale</div>
                </div>
                <div style="width:1px;height:60px;background:var(--border,#E2E5EA);"></div>
                <div style="text-align:center;">
                    <div style="font-family:var(--font-serif);font-size:2.5rem;font-weight:700;color:var(--blue);line-height:1;">128</div>
                    <div style="font-size:0.55rem;letter-spacing:0.15em;text-transform:uppercase;color:#666;margin-top:8px;">Avis vérifiés</div>
                </div>
                <div style="width:1px;height:60px;background:var(--border,#E2E5EA);"></div>
                <div style="text-align:center;">
                    <div style="font-family:var(--font-serif);font-size:2.5rem;font-weight:700;color:var(--red);line-height:1;">98%</div>
                    <div style="font-size:0.55rem;letter-spacing:0.15em;text-transform:uppercase;color:#666;margin-top:8px;">Recommandent</div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section-cta">
    <div class="container">
        <div class="cta-band reveal">
            <div class="cta-text">
                <h3>Prêt à prendre<br>la <em>route</em> ?</h3>
                <p>Réservez en ligne en quelques clics ou contactez notre équipe pour un accompagnement personnalisé.</p>
            </div>
            <div class="cta-actions">
                <div class="cta-phone-label">Appelez-nous</div>
                <div class="cta-phone">+253 77 00 00 00</div>
                <a href="pages/location_vehicule.php" class="btn-primary" style="margin-top:10px">
                    <span>Réserver en ligne</span>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ===================== MAP AGENCE ===================== -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<section class="section-map reveal">
    <div class="container">
        <div class="section-header" style="margin-bottom:40px">
            <div>
                <div class="section-eyebrow"><span>Nous trouver</span></div>
                <h3 class="section-title">Notre <em>agence</em> à Djibouti</h3>
            </div>
            <a href="pages/contact.php" class="section-link">Nous contacter →</a>
        </div>
        <div style="display:grid;grid-template-columns:1fr 320px;gap:20px;align-items:stretch">
            <div id="home-map" style="height:400px;border:1px solid rgba(0,160,220,0.15)"></div>
            <div style="background:#FFFFFF;border:1px solid rgba(0,160,220,0.1);padding:36px 28px;display:flex;flex-direction:column;justify-content:space-between;">
                <div>
                    <div style="font-size:0.58rem;font-weight:600;letter-spacing:0.3em;text-transform:uppercase;color:var(--green);margin-bottom:16px">Adresse</div>
                    <p style="font-family:var(--font-serif); color: #111111 !important; font-weight: 700; color: #111111; font-weight: 700; font-weight:700;font-size:1.4rem;font-weight:300;line-height:1.4;margin-bottom:24px">Djibouti-Ville<br><em style="color:var(--accent)">Venise</em></p>
                    <div style="display:flex;flex-direction:column;gap:14px">
                        <div style="display:flex;align-items:center;gap:12px;font-size:0.75rem;color:#111111">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.61 3.3 2 2 0 0 1 3.6 1h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8.6a16 16 0 0 0 6 6l.92-.91a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                            +253 77 00 00 00
                        </div>
                        <div style="display:flex;align-items:center;gap:12px;font-size:0.75rem;color:#111111">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                            contact@kamk.dj
                        </div>
                        <div style="display:flex;align-items:center;gap:12px;font-size:0.75rem;color:#111111">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                            Lun – Sam : 7h00 – 20h00
                        </div>
                    </div>
                </div>
                <a href="pages/location_vehicule.php" class="btn-primary" style="margin-top:32px;text-align:center;display:block">
                    <span>Voir les véhicules disponibles</span>
                </a>
            </div>
        </div>
    </div>
</section>
<style>
.section-map { padding: 0 0 140px; }
@media(max-width:900px) {
    .section-map > .container > div:last-child { grid-template-columns:1fr !important; }
    #home-map { height:280px !important; }
}
</style>
<script>
window.addEventListener('load', function() {
    // Centré sur tout Djibouti pour voir les 5 régions
    const hmap = L.map('home-map', { center:[11.8000, 42.9000], zoom:7, zoomControl:true });
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { attribution:'© OpenStreetMap' }).addTo(hmap);

    const agenceIcon = L.divIcon({
        html:`<div style="background:#008C3A;width:18px;height:18px;border-radius:50%;border:3px solid white;box-shadow:0 0 14px rgba(0,160,220,0.9)"></div>`,
        className:'', iconSize:[18,18]
    });
    const regionIcon = L.divIcon({
        html:`<div style="background:#4CAF82;width:12px;height:12px;border-radius:50%;border:2px solid white;box-shadow:0 0 10px rgba(76,175,130,0.8)"></div>`,
        className:'', iconSize:[12,12]
    });

    // Agence KAMK — Djibouti-Ville, Venise
    L.marker([11.5895, 43.1445], {icon:agenceIcon}).addTo(hmap)
     .bindPopup('<b>🏢 Agence KAMK</b><br>Djibouti-Ville, Venise<br>📞 +253 77 00 00 00<br><b>18 véhicules disponibles</b>').openPopup();

    // Les 5 régions
    const regions = [
        { name:'Dikhil', lat:11.1050, lng:42.3700, desc:'Région de l\'Unité' },
        { name:'Tadjourah', lat:11.7900, lng:42.8900, desc:'Région de la Mer Rouge' },
        { name:'Ali Sabieh', lat:11.1550, lng:42.7100, desc:'Région du Sud' },
        { name:'Obock', lat:11.9600, lng:43.2900, desc:'Région du Nord' },
        { name:'Arta', lat:11.5250, lng:42.8500, desc:'Région Centrale' },
    ];

    regions.forEach(r => {
        L.marker([r.lat, r.lng], {icon:regionIcon}).addTo(hmap)
         .bindPopup(`<b>📍 ${r.name}</b><br>${r.desc}<br><small>Service KAMK disponible</small>`);
    });

    // Zone de couverture (cercle autour de Djibouti-Ville)
    L.circle([11.5895, 43.1445], {
        color: 'rgba(0,160,220,0.5)',
        fillColor: 'rgba(0,160,220,0.08)',
        fillOpacity: 1,
        weight: 1,
        radius: 15000
    }).addTo(hmap);
});
</script>

<!-- ===================== PUB PHOTOS ===================== -->
<section class="section-pub">
    <div class="pub-slider" id="pubSlider">

        <!-- SLIDE 1 — Clé -->
        <div class="pub-slide active">
            <div class="pub-photo-wrap">
                <img src="photo1.jpeg" alt="Déverrouillage par clé" class="pub-photo"/>
                <div class="pub-photo-overlay"></div>
                <!-- Icône clé flottante -->
                <div class="pub-floating-icon pub-floating-icon--key">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="7.5" cy="15.5" r="5.5"/>
                        <path d="M21 2l-9.6 9.6M15.5 6.5l2 2"/>
                    </svg>
                    <span>Clé physique</span>
                </div>
            </div>
            <div class="pub-content">
                <div class="pub-tag">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="7.5" cy="15.5" r="5.5"/><path d="M21 2l-9.6 9.6M15.5 6.5l2 2"/></svg>
                    Déverrouillage Classique
                </div>
                <h2 class="pub-title">La liberté<br>à portée de <em>main</em></h2>
                <p class="pub-text">Nos véhicules sont équipés de clés intelligentes haute sécurité. Simple, fiable, instantané — démarrez en toute confiance à chaque location.</p>
                <ul class="pub-features">
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Clé remise à l'agence ou livrée
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Antivol & sécurité renforcée
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Compatible tous nos modèles
                    </li>
                </ul>
                <a href="pages/location_vehicule.php" class="btn-primary"><span>Réserver avec clé</span></a>
            </div>
        </div>

        <!-- SLIDE 2 — Téléphone -->
        <div class="pub-slide">
            <div class="pub-photo-wrap">
                <img src="photo2.jpeg" alt="Déverrouillage par téléphone" class="pub-photo"/>
                <div class="pub-photo-overlay"></div>
                <!-- Icône téléphone flottante -->
                <div class="pub-floating-icon pub-floating-icon--phone">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="5" y="2" width="14" height="20" rx="2"/>
                        <circle cx="12" cy="17" r="1" fill="#008C3A"/>
                    </svg>
                    <span>Via mobile</span>
                </div>
            </div>
            <div class="pub-content">
                <div class="pub-tag">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><rect x="5" y="2" width="14" height="20" rx="2"/><circle cx="12" cy="17" r="1" fill="currentColor"/></svg>
                    Déverrouillage Digital
                </div>
                <h2 class="pub-title">Votre véhicule,<br>depuis votre <em>téléphone</em></h2>
                <p class="pub-text">Grâce à notre technologie connectée, ouvrez et démarrez votre véhicule directement depuis votre smartphone. L'avenir de la mobilité, dès aujourd'hui.</p>
                <ul class="pub-features">
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Application KAMK dédiée
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Ouverture NFC & Bluetooth
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#008C3A" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Historique de location en temps réel
                    </li>
                </ul>
                <a href="pages/location_vehicule.php" class="btn-primary"><span>Réserver en digital</span></a>
            </div>
        </div>

        <!-- SLIDE 3 — Jeune conductrice -->
        <div class="pub-slide">
            <div class="pub-photo-wrap">
                <img src="images/pub3.jpeg" alt="Location KAMK" class="pub-photo"/>
                <div class="pub-photo-overlay"></div>
                <div class="pub-floating-icon pub-floating-icon--key">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="1.5"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                    <span>KAMK Djibouti</span>
                </div>
            </div>
            <div class="pub-content">
                <div class="pub-tag">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                    Nos Clients
                </div>
                <h2 class="pub-title">La confiance de<br>nos <em>clients</em></h2>
                <p class="pub-text">Chez KAMK, chaque client est unique. Nous mettons tout en œuvre pour offrir une expérience de location irréprochable à chaque trajet, partout à Djibouti.</p>
                <ul class="pub-features">
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Service client 7j/7
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Véhicules entretenus et propres
                    </li>
                    <li>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                        Satisfaction garantie
                    </li>
                </ul>
                <a href="pages/contact.php" class="btn-primary"><span>Nous contacter</span></a>
            </div>
        </div>

        <!-- SLIDE 4 -->
        <div class="pub-slide">
            <div class="pub-photo-wrap">
                <img src="images/pub4.jpeg" alt="Équipe KAMK" class="pub-photo"/>
                <div class="pub-photo-overlay"></div>
                <div class="pub-floating-icon pub-floating-icon--key">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="1.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    <span>Notre équipe</span>
                </div>
            </div>
            <div class="pub-content">
                <div class="pub-tag">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    Notre Équipe
                </div>
                <h2 class="pub-title">Des professionnels<br>à votre <em>service</em></h2>
                <p class="pub-text">L'équipe KAMK est composée de professionnels passionnés, dévoués à vous offrir la meilleure expérience de location à Djibouti.</p>
                <ul class="pub-features">
                    <li><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>Expertise locale et internationale</li>
                    <li><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>Disponibles 7j/7</li>
                    <li><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#007A3D" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>Bilingues français & somali</li>
                </ul>
                <a href="pages/contact.php" class="btn-primary"><span>Nous rejoindre</span></a>
            </div>
        </div>

    </div>

    <!-- Contrôles -->
    <div class="pub-controls">
        <button class="pub-dot active" onclick="goToSlide(0)"></button>
        <button class="pub-dot" onclick="goToSlide(1)"></button>
        <button class="pub-dot" onclick="goToSlide(2)"></button>
        <button class="pub-dot" onclick="goToSlide(3)"></button>
    </div>
    <button class="pub-arrow pub-arrow--prev" onclick="prevSlide()">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M15 18l-6-6 6-6"/></svg>
    </button>
    <button class="pub-arrow pub-arrow--next" onclick="nextSlide()">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M9 18l6-6-6-6"/></svg>
    </button>
</section>

<style>
/* ===================== PUB SECTION ===================== */
.section-pub {
    position: relative;
    overflow: hidden;
    background: var(--bg-page);
}

.pub-slider {
    position: relative;
    width: 100%;
    height: 620px;
}

.pub-slide {
    position: absolute;
    inset: 0;
    display: grid;
    grid-template-columns: 1fr 1fr;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.9s ease;
}
.pub-slide.active {
    opacity: 1;
    pointer-events: all;
}

/* Photo side */
.pub-photo-wrap {
    position: relative;
    overflow: hidden;
}
.pub-photo {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center top;
    transition: transform 8s ease;
    transform: scale(1.05);
}
.pub-slide.active .pub-photo { transform: scale(1); }

.pub-photo-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(
        to right,
        transparent 40%,
        var(--black) 100%
    ), linear-gradient(
        to bottom,
        rgba(0,0,0,0.2) 0%,
        transparent 40%,
        rgba(0,0,0,0.4) 100%
    );
}

/* Floating icon badge */
.pub-floating-icon {
    position: absolute;
    bottom: 40px;
    left: 36px;
    display: flex;
    align-items: center;
    gap: 10px;
    background: var(--bg-dark);
    border: 1px solid rgba(0,160,220,0.35);
    backdrop-filter: blur(12px);
    padding: 14px 20px;
    animation: floatBadge 3s ease-in-out infinite;
}
@keyframes floatBadge {
    0%, 100% { transform: translateY(0); }
    50%       { transform: translateY(-6px); }
}
.pub-floating-icon span {
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: var(--green);
}

/* Content side */
.pub-content {
    background: #FFFFFF;
    padding: 70px 64px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    overflow: hidden;
}
.pub-content::before {
    content: '';
    position: absolute;
    top: -80px; right: -80px;
    width: 300px; height: 300px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(0,160,220,0.1) 0%, transparent 70%);
}

.pub-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-size: 0.6rem;
    font-weight: 600;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--green);
    border: 1px solid rgba(0,160,220,0.25);
    padding: 7px 14px;
    margin-bottom: 28px;
    width: fit-content;
}

.pub-title {
    font-family: var(--font-serif);
    font-size: clamp(2rem, 3.5vw, 3rem);
    font-weight: 700;
    line-height: 1.1;
    letter-spacing: 0.02em;
    margin-bottom: 22px;
    color: #FFFFFF;
}
.pub-title em { font-style: italic; color: var(--blue); }

.pub-text {
    font-size: 0.82rem;
    line-height: 1.9;
    color: rgba(255,255,255,0.80);
    margin-bottom: 30px;
    max-width: 400px;
}

.pub-features {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 40px;
}
.pub-features li {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 0.78rem;
    color: rgba(255,255,255,0.75);
}

/* Arrows */
.pub-arrow {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 48px; height: 48px;
    border: 1px solid rgba(0,160,220,0.25);
    background: var(--bg-dark);
    backdrop-filter: blur(8px);
    color: #111111;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: border-color 0.3s, background 0.3s;
    z-index: 10;
}
.pub-arrow:hover { border-color: var(--green); background: var(--bg-white); }
.pub-arrow--prev { left: 20px; }
.pub-arrow--next { right: 20px; }

/* Dots */
.pub-controls {
    position: absolute;
    bottom: 28px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 10px;
    z-index: 10;
}
.pub-dot {
    width: 28px; height: 3px;
    background: rgba(0,160,220,0.25);
    border: none;
    cursor: pointer;
    transition: background 0.3s, width 0.3s;
    padding: 0;
}
.pub-dot.active {
    background: var(--green);
    width: 48px;
}

/* Progress bar */
.pub-progress {
    position: absolute;
    bottom: 0; left: 0;
    height: 2px;
    background: var(--green);
    width: 0%;
    transition: width linear;
    z-index: 10;
}

@media (max-width: 900px) {
    .pub-slider { height: auto; }
    .pub-slide { grid-template-columns: 1fr; position: relative; }
    .pub-slide:not(.active) { display: none; }
    .pub-photo-wrap { height: 320px; }
    .pub-photo-overlay { background: linear-gradient(to bottom, transparent 50%, var(--black) 100%); }
    .pub-content { padding: 40px 28px 60px; }
    .pub-arrow { display: none; }
}
</style>

<script>
// ===================== PUB SLIDER =====================
let currentSlide = 0;
const slides = document.querySelectorAll('.pub-slide');
const dots = document.querySelectorAll('.pub-dot');
const autoDelay = 5000;
let autoTimer;

// Progress bar
const progressBar = document.createElement('div');
progressBar.className = 'pub-progress';
document.querySelector('.section-pub').appendChild(progressBar);

function goToSlide(n) {
    slides[currentSlide].classList.remove('active');
    dots[currentSlide].classList.remove('active');
    currentSlide = (n + slides.length) % slides.length;
    slides[currentSlide].classList.add('active');
    dots[currentSlide].classList.add('active');
    resetProgress();
}
function nextSlide() { goToSlide(currentSlide + 1); }
function prevSlide() { goToSlide(currentSlide - 1); }

function resetProgress() {
    progressBar.style.transition = 'none';
    progressBar.style.width = '0%';
    clearTimeout(autoTimer);
    requestAnimationFrame(() => {
        requestAnimationFrame(() => {
            progressBar.style.transition = `width ${autoDelay}ms linear`;
            progressBar.style.width = '100%';
        });
    });
    autoTimer = setTimeout(nextSlide, autoDelay);
}

resetProgress();
</script>

<!-- ===================== FOOTER ===================== -->
<footer>
    <div class="container">
        <div class="footer-inner">
            <div class="footer-brand">
                <a href="index.php" class="logo">
                    <span class="logo-main">KAMK</span>
                    <span class="logo-sub">Location de Véhicules</span>
                </a>
                <p>L'excellence en matière de location de véhicules. Confort, fiabilité et service premium depuis notre création.</p>
            </div>

            <div class="footer-col">
                <h5>Navigation</h5>
                <ul>
                    <li><a href="index.php">Accueil</a></li>
                    <li><a href="pages/location_vehicule.php">Véhicules</a></li>
                    <li><a href="pages/tarifs.php">Tarifs</a></li>
                    <li><a href="pages/tutoriel.php">Tutoriel</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h5>Services</h5>
                <ul>
                    <li><a href="#">Location courte durée</a></li>
                    <li><a href="#">Location longue durée</a></li>
                    <li><a href="#">Véhicules premium</a></li>
                    <li><a href="#">Livraison à domicile</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h5>Contact</h5>
                <ul>
                    <li><a href="pages/contact.php">Formulaire de contact</a></li>
                    <li><a href="mailto:contact@kamk.fr">contact@kamk.fr</a></li>
                    <li><a href="#">+33 1 00 00 00 00</a></li>
                    <li><a href="pages/connexion.php">Espace client</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2026 KAMK — Tous droits réservés</p>
            <p style="font-size:0.65rem; color:rgba(255,255,255,0.4); letter-spacing:0.1em;">Mentions légales · Politique de confidentialité</p>
        </div>
    </div>
</footer>

<script>
// Header scroll effect
const header = document.getElementById('site-header');
window.addEventListener('scroll', () => {
    header.classList.toggle('scrolled', window.scrollY > 60);
});

// Reveal on scroll
const reveals = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
reveals.forEach(el => observer.observe(el));


// ===== MÉTÉO DJIBOUTI (OpenWeatherMap — clé gratuite) =====
async function loadMeteo() {
    try {
        // Coordonnées Djibouti-Ville
        const lat = 11.5890, lon = 43.1450;
        // API gratuite wttr.in — pas besoin de clé !
        const res = await fetch(`https://wttr.in/${lat},${lon}?format=j1`);
        const data = await res.json();
        const current = data.current_condition[0];

        const temp = current.temp_C;
        const feels = current.FeelsLikeC;
        const humidity = current.humidity;
        const wind = current.windspeedKmph;
        const desc = current.lang_fr?.[0]?.value || current.weatherDesc[0].value;
        const code = parseInt(current.weatherCode);

        // Icône selon code météo
        let icon = '☀️';
        if (code >= 200 && code < 300) icon = '⛈️';
        else if (code >= 300 && code < 400) icon = '🌧️';
        else if (code >= 500 && code < 600) icon = '🌧️';
        else if (code >= 600 && code < 700) icon = '❄️';
        else if (code >= 700 && code < 800) icon = '🌫️';
        else if (code === 800) icon = '☀️';
        else if (code > 800) icon = '⛅';

        // Conseil véhicule selon météo
        let conseil = '';
        if (parseInt(temp) >= 38) conseil = '🌡️ Chaleur intense — Climatisation incluse dans tous nos véhicules. Préférez une sortie tôt le matin.';
        else if (code >= 200 && code < 600) conseil = '🌧️ Pluie détectée — Nous recommandons un 4x4 ou SUV pour plus de sécurité sur routes mouillées.';
        else if (parseInt(wind) > 40) conseil = '💨 Vents forts — Évitez les routes côtières. Nos 4x4 offrent une meilleure stabilité.';
        else conseil = '✅ Conditions idéales — Parfait pour explorer Djibouti ! Toute notre flotte est disponible.';

        document.getElementById('meteo-temp').textContent = temp + '°C';
        document.getElementById('meteo-desc').textContent = desc;
        document.getElementById('meteo-icon').textContent = icon;
        document.getElementById('meteo-hum').textContent = humidity + '%';
        document.getElementById('meteo-wind').textContent = wind + ' km/h';
        document.getElementById('meteo-feels').textContent = feels + '°C';
        document.getElementById('meteo-conseil').textContent = conseil;

        document.getElementById('meteo-loading').style.display = 'none';
        document.getElementById('meteo-content').style.display = 'block';

    } catch(e) {
        document.getElementById('meteo-loading').innerHTML = '<div style="font-size:1.5rem;margin-bottom:8px;">🌤️</div><div style="font-size:0.7rem;opacity:0.6;">Météo temporairement indisponible</div>';
    }
}
loadMeteo();
</script>
<script src="assets/theme.js"></script>
</body>
</html>