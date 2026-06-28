<%@ Page Title="Portal Access" Language="C#" AutoEventWireup="True" CodeBehind="Login.aspx.cs" Inherits="Museum_Artifact_Preservation_Management_System.Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> — MAPM System</title>
    <meta name="description" content="Museum Artifact Preservation Management System — secure portal access for administrators and staff." />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* ═══════════════════════════════════════════════
           TOKENS
        ═══════════════════════════════════════════════ */
        :root {
            --bg-deep:      #05080f;
            --bg-mid:       #0c1220;
            --bg-card:      rgba(12,18,35,0.82);
            --gold-bright:  #f0c040;
            --gold-mid:     #c8960c;
            --gold-dark:    #8a6508;
            --gold-glow:    rgba(200,150,12,0.35);
            --blue-accent:  #3b82f6;
            --blue-glow:    rgba(59,130,246,0.3);
            --border-soft:  rgba(200,150,12,0.2);
            --border-focus: rgba(200,150,12,0.6);
            --text-primary: #f1e8cc;
            --text-muted:   #8a8fa8;
            --text-dim:     #4a5070;
            --danger:       #e74c3c;
            --success:      #2ecc71;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        /* ═══════════════════════════════════════════════
           BODY / CANVAS
        ═══════════════════════════════════════════════ */
        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-deep);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
            position: relative;
            overflow: hidden;
        }

        /* ── Starfield canvas ── */
        #starCanvas {
            position: fixed;
            inset: 0;
            pointer-events: none;
            z-index: 0;
        }

        /* ── Ambient glows ── */
        .glow-orb {
            position: fixed;
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }
        .glow-orb-1 {
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(200,150,12,0.12) 0%, transparent 70%);
            top: -150px; right: -150px;
            animation: orb-drift 12s ease-in-out infinite alternate;
        }
        .glow-orb-2 {
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(59,130,246,0.10) 0%, transparent 70%);
            bottom: -150px; left: -150px;
            animation: orb-drift 15s ease-in-out infinite alternate-reverse;
        }
        .glow-orb-3 {
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(200,150,12,0.08) 0%, transparent 70%);
            top: 40%; left: 40%;
            animation: orb-drift 9s ease-in-out infinite alternate;
        }
        @keyframes orb-drift {
            from { transform: translate(0,0) scale(1); }
            to   { transform: translate(40px, 30px) scale(1.15); }
        }

        /* ── Decorative lines ── */
        .deco-line {
            position: fixed;
            pointer-events: none;
            z-index: 0;
            opacity: 0.06;
        }
        .deco-line-h {
            width: 100vw; height: 1px;
            background: linear-gradient(90deg, transparent, var(--gold-mid), transparent);
        }
        .deco-line-h-1 { top: 30%; }
        .deco-line-h-2 { top: 70%; }
        .deco-line-v {
            height: 100vh; width: 1px;
            background: linear-gradient(180deg, transparent, var(--gold-mid), transparent);
        }
        .deco-line-v-1 { left: 20%; }
        .deco-line-v-2 { left: 80%; }

        /* ═══════════════════════════════════════════════
           CARD
        ═══════════════════════════════════════════════ */
        .login-card {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 480px;
            background: var(--bg-card);
            backdrop-filter: blur(32px) saturate(1.4);
            -webkit-backdrop-filter: blur(32px) saturate(1.4);
            border: 1px solid var(--border-soft);
            border-radius: 24px;
            padding: 48px 44px 40px;
            box-shadow:
                0 0 0 1px rgba(200,150,12,0.06),
                0 8px 32px rgba(0,0,0,0.6),
                0 32px 80px rgba(0,0,0,0.5),
                inset 0 1px 0 rgba(255,255,255,0.06);
            color: var(--text-primary);
            overflow: hidden;
        }

        /* Inner shimmer stripe */
        .login-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent 0%, var(--gold-mid) 30%, var(--gold-bright) 50%, var(--gold-mid) 70%, transparent 100%);
            opacity: 0.7;
        }
        /* Corner accent */
        .login-card::after {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 200px; height: 200px;
            background: radial-gradient(circle, rgba(200,150,12,0.08) 0%, transparent 70%);
            border-radius: 50%;
        }

        /* ═══════════════════════════════════════════════
           BRAND / LOGO
        ═══════════════════════════════════════════════ */
        .login-brand {
            text-align: center;
            margin-bottom: 36px;
        }

        /* SVG logo emblem */
        .logo-emblem {
            width: 80px;
            height: 80px;
            margin: 0 auto 18px;
            display: block;
            filter: drop-shadow(0 0 18px rgba(200,150,12,0.55));
            animation: logo-pulse 4s ease-in-out infinite alternate;
        }
        @keyframes logo-pulse {
            from { filter: drop-shadow(0 0 14px rgba(200,150,12,0.45)); transform: translateY(0); }
            to   { filter: drop-shadow(0 0 28px rgba(200,150,12,0.75)); transform: translateY(-3px); }
        }

        .login-brand h1 {
            font-family: 'Cinzel', serif;
            font-size: 1.8rem;
            font-weight: 900;
            letter-spacing: 0.12em;
            background: linear-gradient(135deg, var(--gold-bright) 0%, #fff8dc 45%, var(--gold-mid) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1.2;
            margin-bottom: 6px;
        }
        .login-brand .brand-sub {
            font-size: 0.75rem;
            font-weight: 400;
            letter-spacing: 0.22em;
            text-transform: uppercase;
            color: var(--text-muted);
        }

        /* Divider */
        .brand-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 22px 0 28px;
        }
        .brand-divider-line {
            flex: 1;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--border-soft));
        }
        .brand-divider-line:last-child {
            background: linear-gradient(270deg, transparent, var(--border-soft));
        }
        .brand-divider-diamond {
            width: 6px; height: 6px;
            background: var(--gold-mid);
            transform: rotate(45deg);
            border-radius: 1px;
        }

        /* ═══════════════════════════════════════════════
           ROLE TABS
        ═══════════════════════════════════════════════ */
        .role-tabs {
            display: flex;
            background: rgba(5,8,15,0.6);
            border: 1px solid rgba(200,150,12,0.12);
            border-radius: 12px;
            padding: 5px;
            margin-bottom: 28px;
            gap: 5px;
        }
        .role-tab {
            flex: 1;
            padding: 10px 0;
            border: none;
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 0.82rem;
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            color: var(--text-dim);
            background: transparent;
        }
        .role-tab.active {
            background: linear-gradient(135deg, var(--gold-dark), var(--gold-mid));
            color: #fff;
            box-shadow: 0 4px 16px var(--gold-glow), inset 0 1px 0 rgba(255,255,255,0.15);
        }
        .role-tab.active.user-tab {
            background: linear-gradient(135deg, #1d4ed8, var(--blue-accent));
            box-shadow: 0 4px 16px var(--blue-glow), inset 0 1px 0 rgba(255,255,255,0.15);
        }
        .role-tab:not(.active):hover {
            color: var(--text-primary);
            background: rgba(200,150,12,0.08);
        }

        /* ═══════════════════════════════════════════════
           HINT BOX
        ═══════════════════════════════════════════════ */
        .mode-hint {
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 0.8rem;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            line-height: 1.6;
            backdrop-filter: blur(8px);
        }
        .mode-hint.admin-hint {
            background: rgba(200,150,12,0.09);
            border: 1px solid rgba(200,150,12,0.22);
            color: #fde68a;
        }
        .mode-hint.user-hint {
            background: rgba(59,130,246,0.09);
            border: 1px solid rgba(59,130,246,0.22);
            color: #bfdbfe;
        }
        .mode-hint i { margin-top: 2px; flex-shrink: 0; font-size: 0.9rem; }

        /* ═══════════════════════════════════════════════
           FORM FIELDS
        ═══════════════════════════════════════════════ */
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-icon {
            position: absolute;
            left: 14px;
            color: var(--text-dim);
            font-size: 0.85rem;
            transition: color 0.2s;
            pointer-events: none;
        }
        .form-control {
            width: 100%;
            padding: 13px 16px 13px 40px;
            background: rgba(5,8,15,0.7);
            border: 1px solid rgba(200,150,12,0.15);
            border-radius: 10px;
            color: var(--text-primary);
            font-size: 0.92rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.25s ease;
        }
        .form-control::placeholder { color: var(--text-dim); }
        .form-control:focus {
            outline: none;
            border-color: var(--gold-mid);
            box-shadow: 0 0 0 3px var(--gold-glow), 0 2px 12px rgba(200,150,12,0.1);
            background: rgba(8,12,22,0.9);
        }
        .form-control:focus + .input-icon,
        .input-wrapper:focus-within .input-icon { color: var(--gold-mid); }
        /* Reorder so icon is painted after input but positioned absolute */
        .input-wrapper .form-control { order: 1; }
        .input-wrapper .input-icon { order: 0; z-index: 2; }

        .user-mode .form-control:focus {
            border-color: var(--blue-accent);
            box-shadow: 0 0 0 3px var(--blue-glow);
        }
        .user-mode .form-control:focus ~ .input-icon { color: var(--blue-accent); }

        /* Password wrapper */
        .form-control.has-toggle { padding-right: 80px; }
        #btnShowCode {
            position: absolute;
            right: 10px;
            z-index: 3;
            background: transparent;
            border: none;
            color: var(--gold-mid);
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 5px 8px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        #btnShowCode:hover {
            background: rgba(200,150,12,0.15);
            color: var(--gold-bright);
        }

        /* ═══════════════════════════════════════════════
           ERROR BOX
        ═══════════════════════════════════════════════ */
        #loginError {
            display: none;
            background: rgba(231,76,60,0.12);
            border: 1px solid rgba(231,76,60,0.35);
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 18px;
            color: #fca5a5;
            font-size: 0.82rem;
            display: none;
            align-items: center;
            gap: 10px;
        }

        /* ═══════════════════════════════════════════════
           OPTIONS ROW
        ═══════════════════════════════════════════════ */
        .login-options {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 26px;
            font-size: 0.82rem;
            color: var(--text-muted);
        }
        .login-options label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        .login-options input[type="checkbox"] {
            width: 15px; height: 15px;
            accent-color: var(--gold-mid);
            cursor: pointer;
        }

        /* ═══════════════════════════════════════════════
           SUBMIT BUTTON
        ═══════════════════════════════════════════════ */
        .btn-submit {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--gold-dark) 0%, var(--gold-mid) 50%, #d4a017 100%);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.9rem;
            font-family: 'Cinzel', serif;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 20px var(--gold-glow);
        }
        .btn-submit::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.15) 50%, transparent 100%);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }
        .btn-submit:hover::before { transform: translateX(100%); }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 28px var(--gold-glow), 0 4px 12px rgba(0,0,0,0.4);
        }
        .btn-submit:active { transform: translateY(0); }

        .user-mode .btn-submit {
            background: linear-gradient(135deg, #1d4ed8 0%, var(--blue-accent) 50%, #60a5fa 100%);
            box-shadow: 0 4px 20px var(--blue-glow);
        }
        .user-mode .btn-submit:hover {
            box-shadow: 0 8px 28px var(--blue-glow), 0 4px 12px rgba(0,0,0,0.4);
        }

        /* ═══════════════════════════════════════════════
           REGISTER LINK
        ═══════════════════════════════════════════════ */
        .register-link {
            text-align: center;
            font-size: 0.82rem;
            color: var(--text-dim);
            padding-top: 20px;
            border-top: 1px solid rgba(200,150,12,0.1);
        }
        .register-link a {
            color: var(--gold-mid);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s, text-shadow 0.2s;
        }
        .register-link a:hover {
            color: var(--gold-bright);
            text-shadow: 0 0 10px var(--gold-glow);
        }

        /* ═══════════════════════════════════════════════
           VERSION BADGE
        ═══════════════════════════════════════════════ */
        .version-badge {
            position: fixed;
            bottom: 16px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 20;
            font-size: 0.68rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--text-dim);
            background: rgba(12,18,35,0.7);
            border: 1px solid rgba(200,150,12,0.1);
            border-radius: 20px;
            padding: 5px 14px;
            backdrop-filter: blur(8px);
        }

        /* ═══════════════════════════════════════════════
           ANIMATIONS
        ═══════════════════════════════════════════════ */
        @keyframes shake {
            0%,100% { transform: translateX(0); }
            15%      { transform: translateX(-10px); }
            30%      { transform: translateX(10px); }
            45%      { transform: translateX(-7px); }
            60%      { transform: translateX(7px); }
            75%      { transform: translateX(-4px); }
            90%      { transform: translateX(4px); }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .login-card { animation: fadeIn 0.6s cubic-bezier(0.22, 1, 0.36, 1) both; }

        /* ═══════════════════════════════════════════════
           RESPONSIVE
        ═══════════════════════════════════════════════ */
        @media (max-width: 520px) {
            .login-card { padding: 36px 28px 32px; }
            .login-brand h1 { font-size: 1.5rem; }
        }
    </style>
</head>
<body>
<canvas id="starCanvas"></canvas>
<div class="glow-orb glow-orb-1"></div>
<div class="glow-orb glow-orb-2"></div>
<div class="glow-orb glow-orb-3"></div>
<div class="deco-line deco-line-h deco-line-h-1"></div>
<div class="deco-line deco-line-h deco-line-h-2"></div>
<div class="deco-line deco-line-v deco-line-v-1"></div>
<div class="deco-line deco-line-v deco-line-v-2"></div>

<form runat="server">
<div class="login-card" id="loginCard">

    <!-- ── Brand ─────────────────────────────── -->
    <div class="login-brand">
        <!-- Inline SVG Logo -->
        <svg class="logo-emblem" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
            <defs>
                <linearGradient id="goldGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%"   stop-color="#f0c040"/>
                    <stop offset="50%"  stop-color="#c8960c"/>
                    <stop offset="100%" stop-color="#8a6508"/>
                </linearGradient>
                <linearGradient id="goldGrad2" x1="0%" y1="100%" x2="100%" y2="0%">
                    <stop offset="0%"   stop-color="#c8960c"/>
                    <stop offset="100%" stop-color="#f5d060"/>
                </linearGradient>
                <filter id="glow">
                    <feGaussianBlur stdDeviation="1.5" result="blur"/>
                    <feComposite in="SourceGraphic" in2="blur" operator="over"/>
                </filter>
            </defs>
            <!-- Outer shield -->
            <path d="M40 4 L70 16 L70 42 Q70 62 40 76 Q10 62 10 42 L10 16 Z"
                  fill="none" stroke="url(#goldGrad)" stroke-width="1.5" opacity="0.8"/>
            <!-- Inner shield -->
            <path d="M40 12 L63 22 L63 41 Q63 57 40 68 Q17 57 17 41 L17 22 Z"
                  fill="rgba(200,150,12,0.07)" stroke="url(#goldGrad2)" stroke-width="1"/>
            <!-- Column base platform -->
            <rect x="22" y="60" width="36" height="3" rx="1.5" fill="url(#goldGrad)" opacity="0.9"/>
            <!-- Column pedestal -->
            <rect x="25" y="57" width="30" height="3" rx="1.5" fill="url(#goldGrad)" opacity="0.8"/>
            <!-- Three columns -->
            <rect x="27" y="30" width="5"  height="27" rx="2.5" fill="url(#goldGrad)" opacity="0.9"/>
            <rect x="37.5" y="30" width="5" height="27" rx="2.5" fill="url(#goldGrad)"/>
            <rect x="48" y="30" width="5"  height="27" rx="2.5" fill="url(#goldGrad)" opacity="0.9"/>
            <!-- Column capitals -->
            <rect x="25" y="28" width="9"  height="3" rx="1.5" fill="url(#goldGrad2)"/>
            <rect x="35.5" y="28" width="9" height="3" rx="1.5" fill="url(#goldGrad2)"/>
            <rect x="46" y="28" width="9"  height="3" rx="1.5" fill="url(#goldGrad2)"/>
            <!-- Entablature / frieze -->
            <rect x="23" y="23" width="34" height="5" rx="2" fill="url(#goldGrad)"/>
            <!-- Triangular pediment -->
            <polygon points="22,23 58,23 40,13" fill="none" stroke="url(#goldGrad)" stroke-width="1.5" stroke-linejoin="round"/>
            <!-- Star / artifact gem in pediment -->
            <polygon points="40,16 41.2,19.5 44.9,19.5 41.9,21.6 43,25 40,22.8 37,25 38.1,21.6 35.1,19.5 38.8,19.5"
                     fill="url(#goldGrad2)" filter="url(#glow)"/>
        </svg>

        <h1>MAPM System</h1>
        <div class="brand-sub">Museum Artifact Preservation</div>

        <div class="brand-divider">
            <div class="brand-divider-line"></div>
            <div class="brand-divider-diamond"></div>
            <div class="brand-divider-line"></div>
        </div>
    </div>

    <!-- ── Role Tabs ──────────────────────────── -->
    <div class="role-tabs">
        <button type="button" class="role-tab active" id="tabAdmin" onclick="switchMode('admin')">
            <i class="fas fa-shield-halved"></i> Administrator
        </button>
        <button type="button" class="role-tab user-tab" id="tabUser" onclick="switchMode('user')">
            <i class="fas fa-user-graduate"></i> Staff / User
        </button>
    </div>

    <!-- ── Admin hint ──────────────────────────── -->
    <div class="mode-hint admin-hint" id="hintAdmin">
        <i class="fas fa-circle-info"></i>
        <span>Enter your email and the system <strong>Access Code</strong> to gain full administrative access.</span>
    </div>

    <!-- ── User hint ───────────────────────────── -->
    <div class="mode-hint user-hint" id="hintUser" style="display:none;">
        <i class="fas fa-circle-info"></i>
        <span>Enter your credentials for <strong>view-only</strong> access to artifacts and exhibitions.</span>
    </div>

    <!-- ── Email ───────────────────────────────── -->
    <div class="form-group">
        <label for="txtEmail">Email Address</label>
        <div class="input-wrapper">
            <i class="fas fa-envelope input-icon"></i>
            <input type="text" id="txtEmail" class="form-control" placeholder="you@example.com" autocomplete="email" />
        </div>
    </div>

    <!-- ── Password ────────────────────────────── -->
    <div class="form-group">
        <label for="txtPassword" id="passwordLabel">Access Code</label>
        <div class="input-wrapper">
            <i class="fas fa-key input-icon"></i>
            <input type="password" id="txtPassword" class="form-control has-toggle" placeholder="Enter access code" autocomplete="current-password" />
            <button type="button" id="btnShowCode" onclick="toggleShowCode()" title="Show / Hide">
                <i class="fas fa-eye" id="eyeIcon"></i>
                <span id="showCodeLabel">Show</span>
            </button>
        </div>
    </div>

    <!-- ── Error ───────────────────────────────── -->
    <div id="loginError">
        <i class="fas fa-circle-exclamation"></i>
        <span id="loginErrorMsg"></span>
    </div>

    <!-- ── Options ─────────────────────────────── -->
    <div class="login-options">
        <label>
            <input type="checkbox" id="chkRemember" checked />
            Remember me
        </label>
    </div>

    <!-- ── Submit ──────────────────────────────── -->
    <button type="button" class="btn-submit" id="btnSubmit" onclick="validateLogin()">
        <i class="fas fa-dungeon" style="margin-right:10px;"></i>Enter the Archive
    </button>

    <!-- ── Register link ───────────────────────── -->
    <div class="register-link">
        New visitor? <a href="Register.aspx">Create a Staff Account</a>
    </div>

</div>
</form>

<div class="version-badge">MAPM &nbsp;·&nbsp; v2.0 &nbsp;·&nbsp; Secure Portal</div>

<script>
    /* ═══════════════════════════════════════════
       STARFIELD
    ═══════════════════════════════════════════ */
    (function () {
        var canvas = document.getElementById('starCanvas');
        var ctx = canvas.getContext('2d');
        var stars = [];

        function resize() {
            canvas.width  = window.innerWidth;
            canvas.height = window.innerHeight;
        }

        function initStars() {
            stars = [];
            var count = Math.floor((canvas.width * canvas.height) / 6000);
            for (var i = 0; i < count; i++) {
                stars.push({
                    x: Math.random() * canvas.width,
                    y: Math.random() * canvas.height,
                    r: Math.random() * 1.2 + 0.2,
                    a: Math.random(),
                    speed: Math.random() * 0.003 + 0.001,
                    phase: Math.random() * Math.PI * 2,
                    gold: Math.random() < 0.15
                });
            }
        }

        var frame = 0;
        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            frame += 0.01;
            stars.forEach(function(s) {
                var alpha = s.a * (0.5 + 0.5 * Math.sin(frame * s.speed * 60 + s.phase));
                ctx.beginPath();
                ctx.arc(s.x, s.y, s.r, 0, Math.PI * 2);
                ctx.fillStyle = s.gold
                    ? 'rgba(200,150,12,' + alpha + ')'
                    : 'rgba(200,210,255,' + alpha * 0.6 + ')';
                ctx.fill();
            });
            requestAnimationFrame(draw);
        }

        resize();
        initStars();
        draw();
        window.addEventListener('resize', function() { resize(); initStars(); });
    })();

    /* ═══════════════════════════════════════════
       LOGIN LOGIC
    ═══════════════════════════════════════════ */
    var ADMIN_ACCESS_CODE = 'password123';
    var currentMode = 'admin';

    function switchMode(mode) {
        currentMode = mode;
        var card    = document.getElementById('loginCard');
        var tabA    = document.getElementById('tabAdmin');
        var tabU    = document.getElementById('tabUser');
        var hintA   = document.getElementById('hintAdmin');
        var hintU   = document.getElementById('hintUser');
        var pwLabel = document.getElementById('passwordLabel');
        var btn     = document.getElementById('btnSubmit');

        hideError();

        if (mode === 'admin') {
            card.classList.remove('user-mode');
            tabA.classList.add('active');
            tabU.classList.remove('active');
            hintA.style.display = 'flex';
            hintU.style.display = 'none';
            pwLabel.textContent = 'Access Code';
            document.getElementById('txtPassword').placeholder = 'Enter access code';
            btn.innerHTML = '<i class="fas fa-shield-halved" style="margin-right:10px;"></i>Admin — Enter the Archive';
        } else {
            card.classList.add('user-mode');
            tabU.classList.add('active');
            tabA.classList.remove('active');
            hintA.style.display = 'none';
            hintU.style.display = 'flex';
            pwLabel.textContent = 'Password';
            document.getElementById('txtPassword').placeholder = 'Enter your password';
            btn.innerHTML = '<i class="fas fa-user-graduate" style="margin-right:10px;"></i>User — Enter the Archive';
        }
    }

    function validateLogin() {
        var email    = document.getElementById('txtEmail').value.trim();
        var password = document.getElementById('txtPassword').value;
        var emailPat = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        hideError();

        if (!email)                    { showError('Please enter your email address.');          return; }
        if (!emailPat.test(email))     { showError('Invalid email format (e.g. you@gmail.com).'); return; }
        if (!password)                 { showError(currentMode === 'admin' ? 'Please enter the Access Code.' : 'Please enter your password.'); return; }

        if (currentMode === 'admin') {
            if (password !== ADMIN_ACCESS_CODE) {
                showError('Incorrect Access Code. Administrative access denied.');
                shakeCard();
                return;
            }
            sessionStorage.setItem('mapm_role',  'admin');
            sessionStorage.setItem('mapm_email', email);
            sessionStorage.setItem('mapm_name',  'Administrator');
        } else {
            if (password.length < 6) { showError('Password must be at least 6 characters.'); return; }
            sessionStorage.setItem('mapm_role',  'user');
            sessionStorage.setItem('mapm_email', email);
            sessionStorage.setItem('mapm_name',  email.split('@')[0]);
        }

        sessionStorage.setItem('mapm_login_url', window.location.href);
        var loginHref    = window.location.href;
        var dashboardUrl = loginHref.substring(0, loginHref.toLowerCase().lastIndexOf('/account/')) + '/Dashboard/Dashboard.aspx';
        window.location.href = dashboardUrl;
    }

    function toggleShowCode() {
        var input = document.getElementById('txtPassword');
        var icon  = document.getElementById('eyeIcon');
        var label = document.getElementById('showCodeLabel');
        var shown = input.type === 'text';
        input.type        = shown ? 'password' : 'text';
        icon.className    = shown ? 'fas fa-eye' : 'fas fa-eye-slash';
        label.textContent = shown ? 'Show' : 'Hide';
    }

    function showError(msg) {
        var div = document.getElementById('loginError');
        document.getElementById('loginErrorMsg').textContent = msg;
        div.style.display = 'flex';
    }
    function hideError() {
        document.getElementById('loginError').style.display = 'none';
    }
    function shakeCard() {
        var c = document.getElementById('loginCard');
        c.style.animation = 'none';
        c.offsetHeight;
        c.style.animation = 'shake 0.5s ease';
    }

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') validateLogin();
    });
</script>
</form>
</body>
</html>