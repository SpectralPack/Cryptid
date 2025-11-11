return {
	descriptions = {
		Back = {
			b_cry_antimatter = {
				name = "反物質デッキ",
				text = {
					"{C:attention}ほぼすべての{}デッキの",
					"{C:legendary,E:1}メリット効果{}を適用する",
				},
				unlock = {
					"{C:attention}ブランクデッキ{}で",
					"{C:attention}ゴールドステーク{}以上の難易度で",
					"ランに勝利する",
				},
			},
			b_cry_antimatter_balanced = {
				name = "反物質デッキ",
				text = {
					"{C:attention}ほぼすべての{}",
					"{C:gold}ゴールドステーク{}以上の", 
					"難易度で勝利済みデッキの",
					"{C:legendary,E:1}メリット効果{}を適用する",
				},
				unlock = {
					"{C:attention}ブランクデッキ{}で",
					"{C:attention}ゴールドステーク{}以上の難易度で",
					"ランに勝利する",
				},
			},
			b_cry_antimatter_custom = {
				name = "反物質デッキ",
				text = {
					"{C:attention}ほぼすべての{}",
					"{C:gold}ゴールドステーク{}以上の", 
					"難易度で勝利済みデッキの",
					"{C:legendary,E:1}メリット効果{}を適用する",
				},
				unlock = {
					"{C:attention}ブランクデッキ{}で",
					"{C:attention}ゴールドステーク{}以上の難易度で",
					"ランに勝利する",
				},
			},
			b_cry_beige = {
				name = "Beige Deck",
				text = {
					"{C:attention}コモン{}ジョーカーが",
					"{C:attention}4倍{}の値を持つ",
				},
				unlock = { -- 既存のメッセージと比較してあっているか不明
					"コレクションに",
					"{C:attention}200{}種類以上の",
					"アイテムを発見する",
				},
			},
			b_cry_beta = {
				name = "Nostalgic Deck",
				text = {
					"{C:attention}Joker{} and {C:attention}Consumable{}",
					"slots are {C:attention}combined",
					"{C:attention}Nostalgic{} ブラインド replace",
					"their updated ブラインド",
				},
				unlock = {
					"Win a run",
					"on {C:attention}Pink Stake",
				},
			},
			b_cry_blank = {
				name = "Blank Deck",
				text = {
					"{C:inactive,E:1}Does nothing?",
				},
			},
			b_cry_bountiful = {
				name = "Bountiful Deck",
				text = {
					"After {C:blue}Play{} or {C:red}Discard{},",
					"always draw {C:attention}5{} cards",
				},
				unlock = {
					"Beat {C:attention}The Serpent",
					"without {C:red}ディスカード",
				},
			},
			b_cry_CCD = {
				name = "CCD Deck",
				text = {
					"Every card is also",
					"a {C:attention}random{} consumable",
				},
				unlock = {
					"Use {C:spectral}Hammerspace",
				},
			},
			b_cry_conveyor = {
				name = "Conveyor Deck",
				text = {
					"Jokers may {C:attention}not{} be moved",
					"At start of round,",
					"{C:attention}duplicate{} rightmost Joker",
					"and {C:attention}destroy{} leftmost Joker",
				},
				unlock = {
					"Use {C:spectral}Analog",
				},
			},
			b_cry_critical = {
				name = "Critical Deck",
				text = {
					"After each hand played,",
					"{C:green}#1# in #2#{} chance for {X:dark_edition,C:white} ^2 {} Mult",
					"{C:green}#1# in #3#{} chance for {X:dark_edition,C:white} ^0.5 {} Mult",
				},
				unlock = {
					"Obtain a {C:attention}Rigged Joker",
				},
			},
			b_cry_e_deck = {
				name = "Edition Deck",
				text = {
					"All cards are {C:dark_edition}#1#{}",
					"Cards cannot change editions",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Discover every",
					"{C:dark_edition}Edition",
				},
			},
			b_cry_encoded = {
				name = "Encoded Deck",
				text = {
					"Start with a {C:cry_code,T:j_cry_CodeJoker}Code Joker{}",
					"and a {C:cry_code,T:j_cry_copypaste}Copy/Paste{}",
					"Only {C:cry_code}Code Cards{} appear in shop",
				},
				unlock = {
					"Use {C:spectral}POINTER://",
				},
			},
			b_cry_equilibrium = {
				name = "Deck of Equilibrium",
				text = {
					"All cards have the",
					"{C:attention}same chance{} of",
					"appearing in shops,",
					"start run with",
					"{C:attention,T:v_overstock_plus}Overstock Plus",
				},
				unlock = {
					"Have {C:attention}100 Jokers",
					"at the same time",
				},
			},
			b_cry_et_deck = {
				name = "Enhancement Deck",
				text = {
					"All {C:attention}トランプ{}",
					"are {C:attention}#1#{}(s)",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Use {C:spectral}Vacuum",
				},
			},
			b_cry_glowing = {
				name = "Glowing Deck",
				text = {
					"Multiply the values of",
					"all Jokers by {X:dark_edition,C:white} X1.25 {}",
					"when Boss ブラインド is defeated",
					"{X:cry_jolly,C:white,s:0.8} Jolly#1#Open#1#Winner#1#-#1#wawa#1#person", --peak loc_vars right here
				},
				unlock = {
					"Win a run",
					"with {C:attention}Beige Deck",
				},
			},
			b_cry_infinite = {
				name = "Infinite Deck",
				text = {
					"You can select {C:attention}any",
					"number of cards",
					"{C:attention}+1{} hand size",
				},
				unlock = {
					"Play a hand containing",
					"{C:attention}6{} or more cards",
				},
			},
			b_cry_misprint = {
				name = "Misprint Deck",
				text = {
					"Values of cards",
					"and ポーカーハンド",
					"are {C:attention}randomized",
				},
				unlock = {
					"Obtain a {C:dark_edition}Glitched{C:attention} Joker",
				},
			},
			b_cry_redeemed = {
				name = "Redeemed Deck",
				text = {
					"When a {C:attention}バウチャー{} is purchased,",
					"gain its {C:attention}extra tiers",
				},
				unlock = {
					"Discover every",
					"{C:attention}バウチャー",
				},
			},
			b_cry_sk_deck = {
				name = "Sticker Deck",
				text = {
					"All cards are {C:attention}#1#{}",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Use {C:spectral}Lock",
				},
			},
			b_cry_sl_deck = {
				name = "Seal Deck",
				text = {
					"All トランプ have a {C:dark_edition}#1#{}",
					"Cards cannot change seals",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Use {C:spectral}Typhoon",
				},
			},
			b_cry_spooky = {
				name = "Spooky Deck",
				text = {
					"Start with an {C:eternal}Eternal{} {C:attention,T:j_cry_chocolate_dice}Chocolate Die",
					"After each {C:attention}アンティ{}, create a",
					"{C:cry_candy}Candy{} or {X:cry_cursed,C:white}Cursed{} Joker",
				},
				unlock = {
					"Obtain a {C:cry_candy}Candy{C:attention} Joker",
				},
			},
			b_cry_st_deck = {
				name = "Suit Deck",
				text = {
					"All トランプ are {C:dark_edition}#1#",
					"and cannot change suits",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Use {C:spectral}Replica",
				},
			},
			b_cry_very_fair = {
				name = "Very Fair Deck",
				text = {
					"{C:blue}-2{} hands, {C:red}-2{} ディスカード",
					"every round",
					"{C:attention}バウチャー{} no longer",
					"appear in the shop",
				},
				unlock = {
					"Win a run",
					"with {C:attention}Blank Deck",
				},
			},
			b_cry_wormhole = {
				name = "Wormhole Deck",
				text = {
					"Start with an {C:cry_exotic}Exotic{C:attention} Joker",
					"Jokers are {C:attention}20X{} more",
					"likely to be {C:dark_edition}ネガティブ",
					"{C:attention}-2{} Joker slots",
				},
				unlock = {
					"Obtain an {C:cry_exotic}Exotic{C:attention} Joker",
				},
			},
			b_cry_legendary = {
				name = "Legendary Deck",
				text = {
					"Start with a {C:legendary}Legendary{C:legendary} Joker",
					"{C:green}#1# in #2#{} chance to create another",
					"when Boss ブラインド is defeated {C:inactive}(空きが必要){}",
				},
				unlock = {
					"Have {C:attention}2 Legendary Jokers",
					"at the same time",
				},
			},
		},
		Blind = {
			bl_cry_box = {
				name = "箱",
				text = {
					"すべてのコモンジョーカーに",
					"デバフがかかる",
				},
			},
			bl_cry_clock = {
				name = "時計",
				text = {
					"このアンティに12秒費やすごとに",
					"ブラインドの要求スコアを +0.1倍 する",
					"増分にはゲームスピードが乗算される",
				},
			},
			bl_cry_hammer = {
				name = "槌",
				text = {
					"すべての奇数カードに",
					"デバフがかかる",
				},
			},
			bl_cry_joke = {
				name = "冗談",
				text = {
					"スコアがブラインドの2倍を上回ると",
					"アンティを #2# にする",
				},
			},
			bl_cry_magic = {
				name = "魔法",
				text = {
					"すべての偶数カードに",
					"デバフがかかる",
				},
			},
			bl_cry_lavender_loop = {
				name = "ラベンダー・ループ",
				text = {
					"このラウンドに6秒費やすごとに",
					"ブラインドの要求スコアを x1.25倍 する",
					"増分にはゲームスピードが乗算される",
				},
			},
			bl_cry_obsidian_orb = {
				name = "黒曜石",
				text = {
					"すべての討伐済みボスブラインドの",
					"能力が発動する",
				},
			},
			bl_cry_oldarm = {
				name = "郷愁の腕",
				text = {
					"4枚以下のカードを",
					"プレイしなければならない",
				},
			},
			bl_cry_oldfish = {
				name = "郷愁の魚",
				text = {
					"すべてのポーカーハンドの", 
					"デフォルト倍率が",
					"1になる",
				},
			},
			bl_cry_oldflint = {
				name = "郷愁のフリント",
				text = {
					"フラッシュが無効になる",
				},
			},
			bl_cry_oldhouse = {
				name = "郷愁の家",
				text = {
					"フルハウスが無効になる",
				},
			},
			bl_cry_oldmanacle = {
				name = "郷愁の手枷",
				text = {
					"倍率 ÷ ディスカード数",
				},
			},
			bl_cry_oldmark = {
				name = "郷愁の印",
				text = {
					"ワンペアを含むポーカーハンドが", 
					"無効になる",
				},
			},
			bl_cry_oldox = {
				name = "郷愁の雄牛",
				text = {
					"すべてのポーカーハンドの", 
					"デフォルトチップが",
					"0 になる",
				},
			},
			bl_cry_oldpillar = {
				name = "郷愁の柱",
				text = {
					"ストレートが無効になる",
				},
			},
			bl_cry_oldserpent = {
				name = "郷愁の大蛇",
				text = {
					"倍率 ÷ プレイされたポーカーハンドのプレイ数",
				},
			},
			bl_cry_pin = {
				name = "ピン",
				text = {
					"エピック以上のレアリティのジョーカーに",
					"デバフがかかる",
				},
			},
			bl_cry_scorch = {
				name = "焼印",
				text = {
					"5枚のカードをプレイしなければならない",
					"プレイされたカードと",
					"ディスカードされたカードは",
					"破壊される"
				},
			},
			bl_cry_greed = {
				name = "強欲",
				text = {
					"ブラインドが選択されたときに", 
					"持っている所持金 $#1# ごとに", 
					"要求スコア +#2#",	
				},
			},
			bl_cry_repulsor = {
				name = "リパルサー",
				text = {
					"左端と右端のジョーカーが",
					"再発動する代わりに",
					"それ以外のジョーカーが発動しない"
				},
			},
			bl_cry_chromatic = {
				name = "色相",
				text = {
					"奇数回目にプレイされたスコアは",
					"マイナスされる",
				},
			},
			bl_cry_landlord = {
				name = "地主",
				text = {
					"ランダムなジョーカーに",
					"レンタルを適用する",
				},
			},
			bl_cry_pinkbow = {
				name = "ピンク・ボウ",
				text = {
					"プレイした時に",
					"ハンドにあるカードのランクが", 
					"ランダムになる",
				},
			},
			bl_cry_sapphire_stamp = {
				name = "サファイア・スタンプ",
				text = {
					"1枚多くのカードを選択する",
					"スコアされる前に", 
					"1枚のランダムなカードが未選択になる",
				},
			},
			bl_cry_shackle = {
				name = "足枷",
				text = {
					"すべてのネガティブジョーカーが",
					"デバフを受ける",
				},
			},
			bl_cry_striker = {
				name = "撃鉄",
				text = {
					"すべてのレアジョーカーが",
					"デバフを受ける",
				},
			},
			bl_cry_tax = {
				name = "税",
				text = {
					"1回のハンドのスコア上限 #1#",
				},
			},
			bl_cry_tornado = {
				name = "ターコイズ・トルネード",
				text = {
					"#2#分の#1# の確率で",
					"プレイしたハンドがスコアされない",
				},
			},
			bl_cry_trick = {
				name = "技",
				text = {
					"各ハンドごとに",
					"手札内の表を向いているカードを裏返す",
				},
			},
			bl_cry_trophy = {
				name = "レモン・トロフィー",
				text = {
					"倍率はチップ数を超えることができない",
				},
			},
			bl_cry_vermillion_virus = {
				name = "ヴァーミリオン・ウィルス",
				text = {
					"各ハンドごとに",
					"ジョーカーの位置をシャッフルする",
				},
			},
			bl_cry_windmill = {
				name = "風車",
				text = {
					"すべてのアンコモンジョーカーが",
					"デバフを受ける",
				},
			},
			bl_cry_decision = {
				name = "判決",
				text = {
					"Fasten Jokers on play or ディスカード",
					"Open a Baneful Buffoon",
					"Pack after round",
				},
			},
		},
		Code = {
			c_cry_crash = {
				name = "://CRASH",
				text = {
					"{C:cry_code,E:1}やめて。",
				},
			},
			c_cry_keygen = {
				name = "://KEYGEN",
				text = {
					"この効果によって以前作成された", 
					"バウチャーを{C:cry_code}破壊{}し",
					"ランダムな {C:cry_code}生モノ バナナ{}を持つ",
					"バウチャーを作成する"
				},
			},
			c_cry_payload = {
				name = "://PAYLOAD",
				text = {
					"次に倒すブラインドが",
					"{C:cry_code}#1#倍{} の利息を与える",
				},
			},
			c_cry_exploit = {
				name = "://EXPLOIT",
				text = {
					"{C:cry_code}現在有効な{}ポーカーハンドを1つ{C:cry_code}選ぶ{}",
					"次のハンドがそのポーカーハンドとして{C:cry_code}計算される{}",
					"一時的な{C:cry_code}昇天値{}を{C:cry_code}1{}得る",
				},
			},
			c_cry_malware = {
				name = "://MALWARE",
				text = {
					"{C:cry_code}手札にある{}すべてのカードに",
					"{C:dark_edition}グリッチ{}を追加する",
				},
			},
			c_cry_nperror = {
				name = "://NPERROR",
				text = {
					"{C:cry_code}最後にプレイしたハンド{}を",
					"手札に戻す",
				},
			},
			c_cry_rework = {
				name = "://REWORK",
				text = {
					"{C:cry_code}選択した{}ジョーカーを破壊し",
					"{C:cry_code}アップグレードされた{} エディションの",
					"{C:cry_code}リワークタグ{}を1つ作成する",
					"{C:inactive,s:0.8}アップグレードの序列はコレクションでの表示順に基づく",
				},
			},
			c_cry_merge = {
				name = "://MERGE",
				text = {
					"選択された1枚の{C:cry_code}トランプ{}と",
					"選択された1枚の{C:cry_code}消耗アイテム{}を融合させる",
				},
			},
			c_cry_commit = {
				name = "://COMMIT",
				text = {
					"{C:cry_code}選択された{}1枚のジョーカーを破壊し",
					"{C:cry_code}同じレアリティ{}の",
					"{C:cry_code}新たな{}ジョーカーを生成する",
				},
			},
			c_cry_machinecode = {
				name = "://MACHINECODE",
				text = {
					"",
				},
			},
			c_cry_spaghetti = {
				name = "://SPAGHETTI",
				text = {
					"{C:cry_code}グリッチ{}の",
					"フードジョーカーを作成する",
				},
			},
			c_cry_seed = {
				name = "://SEED",
				text = {
					"選択された1枚のジョーカーかトランプに",
					"{C:cry_code}リグ{}を付与する",
				},
			},
			c_cry_patch = {
				name = "://PATCH",
				text = {
					"すべてのアイテムから{C:cry_code}デバフ{}を取り除く",
					"ショップの状態をリセットする",
				},
			},
			c_cry_cryupdate = {
				name = "://UPDATE",
				text = {
					"将来の{C:cry_code}アップデート{}で",
					"絶対効果が実装されるはず。",
				},
			},
			c_cry_hook = {
				name = "HOOK://",
				text = {
					"2枚の選択したジョーカーに",
					"{C:cry_code}フック{}を付与する",
				},
			},
			c_cry_oboe = {
				name = "://OFFBYONE",
				text = {
					"次の{C:cry_code}ブースターパック{}には",
					"{C:cry_code}#1#{}枚多くカードが含まれ",
					"{C:cry_code}#1#{}枚多くカードを選択できる",
					"{C:inactive}(現在 {C:cry_code}+#2#{C:inactive})",
				},
			},
			c_cry_assemble = {
				name = "://ASSEMBLE",
				text = {
					"{C:cry_code}選択したハンド{}の{C:cry_code}倍率{}に",
					"現在所有しているジョーカーの枚数に",
					"等しい値を加算する",
				},
			},
			c_cry_inst = {
				name = "://INSTANTIATE",
				text = {
					"選択されたカードと 同じ{C:cry_code}ランク{}のカードと",
					"同じ{C:cry_code}スート{}のカードを",
					"それぞれ1枚ずつドローする",
					"{C:inactive}(可能な場合){}",
				},
			},
			c_cry_revert = {
				name = "://REVERT",
				text = {
					"{C:cry_code}ゲームの状態{}を",
					"{C:cry_code}このアンティ{}の開始時に戻す",
				},
			},
			c_cry_cryfunction = {
				name = "FUNCTION://",
				text = {
					"{C:cry_code}直近3件{}の消耗アイテムが記憶される",
					"このコードを使用すると",
					"{C:cry_code}Function://{}ステッカーを持つ最初のアイテムのコピーを作成する",
				},
			},
			c_cry_run = {
				name = "://RUN",
				text = {
					"{C:cry_code}ブラインド{}中に",
					"{C:cry_code}ショップ{}に訪れることができる",

				},
			},
			c_cry_class = {
				name = "://CLASS",
				text = {
					"選択した{C:cry_code}#1#{}枚のカードを",
					"{C:cry_code}選択した{}種別に強化する",
				},
			},
			c_cry_global = {
				name = "://GLOBAL",
				text = {
					"選択した1枚のトランプが",
					"{C:cry_code}グローバル{}になる",
				},
			},
			c_cry_variable = {
				name = "://VARIABLE",
				text = {
					"選択した{C:cry_code}#1#{}枚のカードを",
					"{C:cry_code}選択した{}カードランクにする",
				},
			},
			c_cry_log = {
				name = "://LOG",
				text = {
					"次のいずれかを{C:cry_code}読み出す{}",
					"・{C:attention}次の{}アンティの{C:attention}ボスブラインド{}と{C:attention}バウチャー{}",
					"・次にショップに出現する{C:attention}5{}枚の {C:attention}ジョーカー{}",
					"・次に{C:attention}ドロー{}する{C:attention}10{}枚の トランプ",
					"{C:inactive}(ブラインド中に限る){}",
				},
			},
			c_cry_quantify = {
				name = "://QUANTIFY",
				text = {
					"選択した {C:attention}#1#{}つの",
					"{C:attention}カード{} か {C:attention}ブースター{} を",
					"{C:attention}ジョーカー{}枠に移動させる",
				},
			},
			c_cry_divide = {
				name = "://DIVIDE",
				text = {
					"現在のショップアイテムを",
					"{C:cry_code}半額{}にする",
				},
			},
			c_cry_multiply = {
				name = "://MULTIPLY",
				text = {
					"ラウンド終了時まで",
					"選択した{C:cry_code}ジョーカー{}の",
					"すべての値を{C:cry_code}2倍{}にする",
				},
			},
			c_cry_delete = {
				name = "://DELETE",
				text = {
					"{C:cry_code}選択した{}ショップアイテムを",
					"{C:cry_code}消滅{}させ",
					"このラン中に",
					"出現しないようにする"
				},
			},
			c_cry_alttab = {
				name = "://ALTTAB",
				text = {
					"{C:cry_code}現在の{}ブラインドを",
					"スキップして得られるタグを作成する",
					"{C:inactive}(現在: {C:cry_code}#1#{C:inactive})",
				},
			},
			c_cry_ctrl_v = {
				name = "://CTRL+V",
				text = {
					"選択されたトランプか消耗品の",
					"{C:cry_code}コピー{}を作る",
				},
			},
			c_cry_reboot = {
				name = "://REBOOT",
				text = {
					"{C:blue}ハンド{}と{C:red}ディスカード{}を初期値に戻し",
					"{C:cry_code}すべての{}カードをデッキに戻す",
					"{C:cry_code}新たに{}手札を引き直す",
				},
			},
			c_cry_semicolon = {
				name = ";//",
				text = {
					"現在の{C:cry_code}ブラインド{}を",
					"精算{C:cry_code}なし{}で 終了させる",
				},
			},
			c_cry_declare = {
				name = "://DECLARE",
				text = {
					"{C:attention}現在{}選択されているカードで構成される",
					"{C:attention}#1#{}を含むと見なされる",
					"{C:cry_code}新しい{}ポーカーハンドを作成する",
					"この効果によって{C:attention}3{}種 {C:inactive}[#2#]{} まで", 
					"役を作ることができる",
				},
			},
		},
		["Content Set"] = {
			set_cry_blind = {
				name = "ブラインド",
				text = {
					"{C:attention}ボスブラインド{} added",
					"by Cryptid",
				},
			},
			set_cry_code = {
				name = "Code Cards",
				text = {
					"{C:cry_code}Code Cards{} and",
					"related content",
				},
			},
			set_cry_cursed = {
				name = "Cursed Jokers",
				text = {
					"Harmful Jokers with",
					"{X:cry_cursed,C:white}Cursed{} rarity",
				},
			},
			set_cry_deck = {
				name = "Decks",
				text = {
					"{C:attention}Decks{} added",
					"by Cryptid",
				},
			},
			set_cry_epic = {
				name = "Epic Jokers",
				text = {
					"Jokers with",
					"{C:cry_epic}Epic{} rarity",
					"{C:inactive,s:0.8}(Between Rare and Legendary)",
				},
			},
			set_cry_exotic = {
				name = "Exotic Jokers",
				text = {
					"Powerful Jokers with",
					"{C:cry_exotic}Exotic{} rarity",
				},
			},
			set_cry_m = {
				name = "M Jokers",
				text = {
					"Jokers related to",
					"the letter {C:attention}M{}",
					"and {C:attention}Jolly Joker",
				},
			},
			set_cry_meme = {
				name = "Meme",
				text = {
					"Things related to",
					"multiple references",
				},
			},
			set_cry_misc = {
				name = "Misc.",
				text = {
					"Things that don't",
					"fit in any other",
					"{C:cry_ascendant}Thematic Set",
				},
			},
			set_cry_misc_joker = {
				name = "Misc. Jokers",
				text = {
					"{C:attention}Jokers{} that don't",
					"fit in any other",
					"{C:cry_ascendant}Thematic Set",
				},
			},
			set_cry_planet = {
				name = "Planet Cards",
				text = {
					"Miscellaneous {C:planet}Planet{} Cards",
					"added by Cryptid",
				},
			},
			set_cry_poker_hand_stuff = {
				name = "Poker Hand Stuff",
				text = {
					"Add 5 new {C:attention}ポーカーハンド",
					"and enable {C:attention}Ascended hands",
				},
			},
			set_cry_spectral = {
				name = "Spectral Cards",
				text = {
					"{C:spectral}Spectral{} Cards added",
					"by Cryptid",
				},
			},
			set_cry_spooky = {
				name = "Spooky Update",
				text = {
					"Spooky Update content,",
					"including {C:cry_candy}Candy{} Jokers",
				},
			},
			set_cry_tag = {
				name = "タグ",
				text = {
					"{C:attention}タグ{} added",
					"by Cryptid",
				},
			},
			set_cry_tier3 = {
				name = "Tier 3 バウチャー",
				text = {
					"An extra {C:attention}tier{}",
					"of バウチャー",
				},
			},
			set_cry_timer = {
				name = "Timer Mechanics",
				text = {
					"Items with {C:attention}time-based",
					"effects and mechanics",
				},
			},
			set_cry_voucher = {
				name = "Misc. バウチャー",
				text = {
					"Tier 1 and 2 {C:attention}バウチャー{}",
					"added by Cryptid",
				},
			},
		},
		Edition = {
			e_cry_astral = {
				name = "アストラル",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{}",
				},
			},
			e_cry_blur = {
				name = "ブラー",
				text = {
					"このカードを {C:attention}再発動{} する",
					"{C:green}#2#分の#1#{} の確率で",
					"更に追加で {C:attention}#3#回{} 再発動する",
				},
			},
			e_cry_double_sided = {
				name = "両面",
				text = {
					"このカードは",
					"{C:attention}裏返す{} ことで",
					"別のカードになる",
					"{C:inactive}(空いている面には",
					"{C:inactive}他のカードを取り込むことができる)",
				},
			},
			e_cry_glass = {
				name = "ワレモノ",
				label = "ワレモノ",
				text = {
					"倍率 {C:white,X:mult} X#3# {}",
					"カードが{C:red}破壊されなかった{}場合に効果を発動する",
					"{C:green}#2#分の#1#{} の確率で破壊されない",
					"{C:inactive}リグを付与できない{}",
				},
			},
			e_cry_glitched = {
				name = "グリッチ",
				text = {
					"カード内の全ての値が",
					"{C:attention}X0.1{} ～ {C:attention}X10{} の範囲で",
					"{C:dark_edition}ランダムになる{}",
					"{C:inactive}(可能な場合){}",
				},
			},
			e_cry_gold = {
				name = "ゴールデン",
				label = "ゴールデン",
				text = {
					"使用 または トリガーされた時", 
					"{C:money}$#1#{} を得る",
				},
			},
			e_cry_m = {
				name = "ジョリー",
				text = {
					"倍率 {C:mult}+#1#{}",
					"かなり{C:attention}陽気な{}気分だ",
				},
			},
			e_cry_mosaic = {
				name = "モザイク",
				text = {
					"チップ {X:chips,C:white} X#1# {}",
				},
			},
			e_cry_noisy = {
				name = "雑音",
				text = {
					"???",
				},
			},
			e_cry_oversat = {
				name = "過飽和",
				text = {
					"カード内の",
					"すべての値が",
					"{C:attention}2倍{} になる",
					"{C:inactive}(可能な場合){}",
				},
			},
		},
		Enhanced = {
			m_cry_echo = {
				name = "エコーカード",
				text = {
					"スコアされた時",
					"{C:green}#3#分の#2#{}の確率で",
					"#1#回 {C:attention}再発動{}させる",
				},
			},
			m_cry_light = {
				name = "ライトカード",
				text = {
					"このカードが他の{C:attention}#4#{}枚 {C:inactive}(#3#){} のスコアリングカードとともにトリガーされた時",
					"倍率{X:mult,C:white}X#1#{} を得て",
					"次のアップグレードまでの要求値を {C:attention}5{} 増やす",
					"{C:inactive}(現在 倍率 {X:mult,C:white}X#2#{C:inactive})",
				},
			},
			m_cry_abstract = {
				name = "アブストラクトカード",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{}",
					"{C:attention}元々{}のランクとスートとしてカウントされる",
					"{C:attention}ラウンド終了時{} または {C:attention}ハンドがプレイされた時{}",
					"{C:green}#5#分の#4#{} の確率で {C:red,E:2}自身を破壊{}",
				},
			},
		},
		Joker = {
			j_cry_test_modest = {
				name = "Test Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
				},
			},
			j_cry_test_mainline = {
				name = "Test Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
					"{C:money}+$44{} at start of {C:attention}ブラインド{}",
				},
			},
			j_cry_test_madness = {
				name = "Test Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
					"{C:money}+$44444{} at start of {C:attention}ブラインド{}",
				},
			},
			j_cry_test_cryptid_in_2025 = {
				name = "Test Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
					"{C:money}+$44444{} at start of {C:attention}ブラインド{}",
				},
			},
			j_cry_adroit = {
				name = "Adroit Joker",
				text = {
					"プレイしたハンドが",
                    "{C:attention}#2#{} を含む場合",
					"チップ {C:chips}+#1#{}",
				},
			},
			j_cry_altgoogol = {
				name = "Nostalgic Googol Play Card",
				text = {
					"Sell this card to create",
					"{C:attention}#1#{} cop#<ies,y>1# of the leftmost {C:attention}Joker{}",
					"{C:inactive,s:0.8}Does not copy Nostalgic Googol Play Cards{}",
					"{C:inactive}(空きが必要){}",
				},
			},
			j_cry_altgoogol_balanced = {
				name = "Nostalgic Googol Play Card",
				text = {
					"Sell this card to create",
					"{C:attention}#1#{} cop#<ies,y>1# of the leftmost {C:attention}Joker{}",
					"{C:inactive,s:0.8}Does not copy Nostalgic Googol Play Cards{}",
					"{C:inactive}(空きが必要){}",
					--todo: add "removes ネガティブ from copy" like Ankh/Invis Joker
				},
			},
			j_cry_antennastoheaven = {
				name = "極楽への天線の如し",
				text = {
					"このジョーカーは",
					"プレイされた{C:attention}7{}か{C:attention}4{}がスコアされる毎に",
					"チップ {X:chips,C:white} X#1# {} を得る",
					"{C:inactive}(現在 チップ {X:chips,C:white}X#2#{C:inactive})",
				},
			},
			j_cry_apjoker = {
				name = "APジョーカー",
				text = { "倍率 {X:mult,C:white} X#1# {} against {C:attention}ボスブラインド{}" },
			},
			j_cry_arsonist = {
				name = "放火魔",
				text = {
					"If played hand",
					"contains a {C:attention}Full House{},",
					"{C:red}destroy{} all cards",
					"after scoring",
				},
			},
			j_cry_astral_bottle = {
				name = "瓶の中の天体",
				text = {
					"When sold, apply {C:dark_edition}Astral{}",
					"and {C:attention}生モノ{} to",
					"a random {C:attention}Joker{}",
				},
			},
			j_cry_astral_bottle_mainline = {
				name = "Astral in a Bottle",
				text = {
					"When sold, apply {C:dark_edition}Astral{}",
					"and {C:attention}生モノ{} to",
					"different, random {C:attention}Jokers{}",
				},
			},
			j_cry_astral_bottle_madness = {
				name = "Astral in a Bottle",
				text = {
					"When sold, apply {C:dark_edition}Astral{}",
					"to a random {C:attention}Joker{}",
				},
			},
			j_cry_big_cube = {
				name = "Big Cube",
				text = {
					"{X:chips,C:white} X#1# {} Chips",
				},
			},
			j_cry_biggestm = {
				name = "Huge",
				text = {
					"倍率 {X:mult,C:white} X#1# {} until end",
					"of round if {C:attention}ポーカーハンド{}",
					"is a {C:attention}#2#{}",
					"{C:inactive}(現在 {C:attention}#3#{}{C:inactive}){}",
					"{C:inactive,s:0.8}not fat, just big boned.",
				},
			},
			j_cry_blacklist = {
				name = "Blacklist",
				text = {
					"If a {C:attention}#1#{} is held in hand or played,",
					"set {C:chips}Chips{} and {C:mult}Mult{} to 0",
					"{C:red,E:2}self destructs{} if no {C:attention}#1#{} in deck",
					"{C:inactive,s:0.8}Rank does not change",
				},
			},
			j_cry_rotten_egg = {
				name = "腐った卵",
				text = {
					"When obtained, set sell value of",
					"all current and future Jokers to {C:attention}$#1#{}",
					"Reduce sell value of all {C:attention}Jokers{} by {C:attention}$#2#{}",
					"At end of round, after gaining {C:attention}$#3#{} {C:inactive}[#4#]{}",
					"from selling {C:attention}Jokers{}, {C:red}Self-destruct{}",
				},
			},
			j_cry_blender = {
				name = "Blender",
				text = {
					"Create a {C:attention}random{}",
					"consumable when a",
					"{C:cry_code}Code{} card is used",
					"{C:inactive}(空きが必要){}",
				},
			},
			j_cry_blurred = {
				name = "ブラージョーカー",
				text = {
					"Gain {C:blue}+#1#{} hand#<s>1# when",
					"{C:attention}ブラインド{} is selected",
				},
			},
			j_cry_bonk = {
				name = "ボンっ",
				text = {
					"Each {C:attention}Joker{} gives {C:chips}+#1#{} Chip#<s>1#",
					"Increase amount by {C:chips}+#2#{} if",
					"{C:attention} ポーカーハンド{} is a {C:attention}#3#{}",
					"{C:inactive,s:0.8}Jolly Jokers give{} {C:chips,s:0.8}+#4#{} {C:inactive,s:0.8}Chip#<s>4# instead{}",
				},
			},
			j_cry_bonkers = {
				name = "Bonkers Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_bonusjoker = {
				name = "ボーナスジョーカー",
				text = {
					"{C:green}#1# in #2#{} chance for each",
					"played {C:attention}Bonus{} card to increase",
					"{C:attention}Joker{} or {C:attention}Consumable slots",
					"by {C:dark_edition}#3#{} when scored",
					"{C:red}Works twice per round",
					"{C:inactive,s:0.8}(Equal chance for each){}",
				},
			},
			j_cry_booster = {
				name = "Booster Joker",
				text = {
					"{C:attention}+#1#{} Booster Pack slot#<s>1#",
					"available in shop",
				},
			},
			j_cry_boredom = {
				name = "Boredom",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"{C:attention}retrigger{} each {C:attention}Joker{}",
					"or {C:attention}played card{}",
					"{C:inactive,s:0.8}Does not affect other Boredom{}",
				},
				unlock = {
					"AFK in the title",
					"screen for",
					"{C:attention}10 minutes",
				},
			},
			j_cry_broken_sync_catalyst = {
				name = "Broken Sync Catalyst",
				text = {
					"Swaps {C:attention}#1#%{} of {C:chips}Chips{} with {C:attention}#1#%{} of {C:mult}Mult{}",
					"{C:inactive,s:0.8}I've seen this one before...",
					"{C:inactive,s:0.8}...it's seen better days.",
				},
			},
			j_cry_thalia = {
				name = "Thalia and Melpomeme",
				text = {
					"{C:white,X:mult}X#1#{} Mult for every",
					"pair of unique rarities",
					"{C:inactive}(現在 {C:white,X:mult}X#2#{C:inactive}){}",
				},
			},
			j_cry_keychange = {
				name = "Key Change",
				text = {
					"Gains {C:white,X:mult}X#1#{} if {C:attention}ポーカーハンド{} has",
					"not been played this round",
					"Resets at {C:attention}end of round{}",
					"{C:inactive}(現在 {C:white,X:mult}X#2#{C:inactive{}){}",
				},
			},
			j_cry_brittle = {
				name = "Brittle Candy",
				text = {
					"For the next {C:attention}#1#{} hand#<s>1#,",
					"add {C:attention}Stone{}, {C:attention}Gold{}, or {C:attention}Steel{} to",
					"the rightmost scoring card",
				},
			},
			j_cry_bubblem = {
				name = "Bubble M",
				text = {
					"Create a {C:dark_edition}Foil {C:attention}Jolly Joker{}",
					"if played hand contains",
					"a {C:attention}#1#{}",
					"{C:red,E:2}self destructs{}",
				},
			},
			j_cry_busdriver = {
				name = "Bus Driver",
				text = {
					"{C:green}#1# in #3#{} chance",
					"for {C:mult}+#2#{} Mult",
					"{C:green}#4# in #3#{} chance",
					"for {C:mult}-#2#{} Mult",
				},
			},
			j_cry_buttercup = {
				name = "Buttercup",
				text = {
					"Can store {C:attention}#1#{} selected shop item#<s>1#",
					"When sold: Add the stored item#<s>1#",
					"to the next shop",
				},
			},
			j_cry_caeruleum = {
				name = "Caeruleum",
				text = {
					"隣接する {C:chips}チップを{}操作するジョーカーは",
					"次に上位の{C:attention}演算子{}を用いて計算される",
					"{C:inactive}(累乗は変化しない)",
				},
			},
			j_cry_candy_basket = {
				name = "Candy Basket",
				text = {
					"Sell this card to create {C:attention}#1#{} {C:cry_candy}Cand#<ies,y>1#",
					"{C:attention}+#2#{} {C:cry_candy}Cand#<ies,y>2#{} every {C:attention}#3#{} ブラインド defeated",
					"{C:attention}+#3#{} {C:cry_candy}Cand#<ies,y>4#{} when {C:attention}Boss ブラインド{} defeated",
				},
			},
			j_cry_candy_buttons = {
				name = "Candy Buttons",
				text = {
					"The next {C:attention}#1#{} reroll#<s>1#",
					"cost {C:money}$1{}",
				},
			},
			j_cry_candy_cane = {
				name = "Candy Cane",
				text = {
					"For the next {C:attention}#1#{} round#<s>1#,",
					"トランプ give {C:money}$#2#",
					"when {C:attention}retriggered",
				},
			},
			j_cry_candy_dagger = {
				name = "Candy Dagger",
				text = {
					"When {C:attention}ブラインド{} is selected,",
					"destroy Joker to the right",
					"to create a {C:cry_candy}Candy{}",
				},
			},
			j_cry_candy_sticks = {
				name = "Candy Sticks",
				text = {
					"Next ボスブラインド's effect isn't active",
					"until you've played {C:attention}#1#{} hand#<s>1#",
				},
			},
			j_cry_canvas = {
				name = "Canvas",
				text = {
					"{C:attention}Retrigger{} all {C:attention}Jokers{} to the left",
					"once for {C:attention}every{} non-{C:blue}Common{C:attention} Joker{}",
					"to the right of this Joker",
				},
				unlock = {
					"Retrigger a {C:attention}Joker",
					"{C:attention}114{} times",
					"in one hand",
				},
			},
			j_cry_canvas_balanced = {
				name = "Canvas",
				text = {
					"{C:attention}Retrigger{} all {C:attention}Jokers{} to the left",
					"once for {C:attention}every{} non-{C:blue}Common{C:attention} Joker{}",
					"to the right of this Joker",
					"{C:inactive}(Up to 2 retriggers)",
				},
				unlock = {
					"Retrigger a {C:attention}Joker",
					"{C:attention}114{} times",
					"in one hand",
				},
			},
			j_cry_caramel = {
				name = "Caramel",
				text = {
					"Each played card gives",
					"{X:mult,C:white}X#1#{} Mult when scored",
					"for the next {C:attention}#2#{} round#<s>2#",
				},
			},
			j_cry_cat_owl = {
				name = "Cat Owl",
				text = {
					"{C:attention}Lucky Cards{} are also",
					"considered {C:attention}Echo Cards",
					"{C:attention}Echo Cards{} are also",
					"considered {C:attention}Lucky Cards",
				},
			},
			j_cry_chad = {
				name = "Chad",
				text = {
					"Retrigger {C:attention}leftmost{} Joker",
					"{C:attention}#1#{} additional time#<s>1#",
				},
			},
			j_cry_chili_pepper = {
				name = "Chili Pepper",
				text = {
					"This Joker gains {X:mult,C:white} X#2# {} Mult",
					"at end of round,",
					"{C:red,E:2}self destructs{} after {C:attention}#3#{} round#<s>3#",
					"{C:inactive}(現在{} {X:mult,C:white} X#1# {} {C:inactive}Mult){}",
				},
			},
			j_cry_chocolate_dice = {
				name = "Chocolate Die",
				text = {
					"Roll a {C:green}d10{} when",
					"{C:attention}ボスブラインド{} defeated",
					"to start an {C:cry_ascendant,E:1}event",
					"{C:inactive}(現在: #1#)",
				},
			},
			j_cry_circulus_pistoris = {
				name = "Circulus Pistoris",
				text = {
					"{X:dark_edition,C:white}^#1#{} Chips and 倍率 {X:dark_edition,C:white}#1#乗{}",
					"if {C:attention}exactly{} #2#",
					"hand#<s>2# remaining",
				},
			},
			j_cry_circus = {
				name = "Circus",
				text = Cryptid.get_circus_description(), --for translaters: this is automatically localized you can copy it over as long as cry_circus_generic is translated too
				unlock = {
					"Obtain a {C:red}Rare{},",
					"{C:cry_epic}Epic{} and {C:legendary}Legendary{}",
					"Joker before {C:attention}アンティ 9",
				},
			},
			j_cry_clash = {
				name = "The Clash",
				text = {
					"倍率 {X:mult,C:white} X#1# {} if played",
					"hand contains",
					"an {C:attention}#2#",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"an {E:1,C:attention}Ultimate Pair",
				},
			},
			j_cry_the = {
				name = "The",
				text = {
					"倍率 {X:mult,C:white} X#1# {} if played",
					"hand is {C:attention}#2#",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}None",
				},
			},
			j_cry_clicked_cookie = {
				name = "Clicked Cookie",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
					"{C:chips}-#2#{} Chip#<s>2# when",
					"you {C:attention}click",
				},
			},
			j_cry_clockwork = {
				name = "Clockwork Joker",
				text = {
					"Retrigger held Steel Cards every {C:attention}#9#{} {C:inactive}(#1#){} hands",
					"This Joker gains {X:mult,C:white}X#6#{} Mult {C:inactive}(X#5#){} every {C:attention}#10#{} {C:inactive}(#2#){} hands",
					"Turn the first played card Steel every {C:attention}#11#{} {C:inactive}(#3#){} hands",
					"Held Steel Cards give +{X:mult,C:white}X#8#{} Mult {C:inactive}(X#7#){} every {C:attention}#12#{} {C:inactive}(#4#){} hands",
				},
			},
			j_cry_CodeJoker = {
				name = "Code Joker",
				text = {
					"Create a {C:dark_edition}ネガティブ{}",
					"{C:cry_code}Code Card{} when",
					"{C:attention}ブラインド{} is selected",
				},
				unlock = {
					"Discover {C:attention}every",
					"{C:cry_code}Code Card",
				},
			},
			j_cry_CodeJoker_modest = {
				name = "Code Joker",
				text = {
					"Create a {C:dark_edition}ネガティブ{}",
					"{C:cry_code}Code Card{} when",
					"{C:attention}ボスブラインド{} is selected",
				},
				unlock = {
					"Discover {C:attention}every",
					"{C:cry_code}Code Card",
				},
			},
			j_cry_coin = {
				name = "Crypto Coin",
				text = {
					"Earn between",
					"{C:money}$#1#{} and {C:money}$#2#{} for",
					"each Joker {C:attention}sold{}",
				},
			},
			j_cry_compound_interest = {
				name = "Compound Interest",
				text = {
					"Earn {C:money}#1#%{} of total money",
					"at end of round,",
					"increases by {C:money}#2#%{} per",
					"consecutive payout",
				},
			},
			j_cry_copypaste = {
				name = "Copy/Paste",
				text = {
					"{C:green}#1# in #2#{} chance to duplicate",
					"used {C:cry_code}Code{} cards",
					"{C:red}Works once per round{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_cry_copypaste_modest = {
				name = "Copy/Paste",
				text = {
					"Duplicate pulled",
					"{C:cry_code}Code{} cards",
					"{C:inactive}(Must have room)",
				},
			},
			j_cry_copypaste_madness = {
				name = "Copy/Paste",
				text = {
					"{C:green}#1# in #2#{} chance to duplicate",
					"used {C:cry_code}Code{} cards",
					"{C:inactive}(Must have room)",
				},
			},
			j_cry_cotton_candy = {
				name = "Cotton Candy",
				text = {
					"When sold, adjacent",
					"{C:attention}Jokers{} become {C:dark_edition}ネガティブ{}",
				},
			},
			j_cry_crustulum = {
				name = "Crustulum",
				text = {
					"This Joker gains {C:chips}+#2#{} Chip#<s>2#",
					"per {C:attention}reroll{} in the shop",
					"{C:green}All rerolls are free{}",
					"{C:inactive}(現在 {C:chips}+#1#{C:inactive} chip#<s>1#)",
				},
			},
			j_cry_cryptidmoment = {
				name = "M Chain",
				text = {
					"Sell this card to",
					"add {C:money}$#1#{} of {C:attention}sell value{}",
					"to every {C:attention}Joker{} card",
				},
			},
			j_cry_cube = {
				name = "Cube",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#",
				},
			},
			j_cry_curse_sob = {
				name = "Sob",
				text = {
					"{C:edition,E:1}you cannot{} {C:cry_ascendant,E:1}run...{}",
					"{C:edition,E:1}you cannot{} {C:cry_ascendant,E:1}hide...{}",
					"{C:dark_edition,E:1}you cannot escape...{}",
					"{C:inactive}(空きが必要){}",
				},
				unlock = {
					"Obtain an {C:purple}Eternal{}",
					"{C:attention}Obelisk",
				},
			},
			j_cry_cursor = {
				name = "Cursor",
				text = {
					"This Joker gains {C:chips}+#2#{} Chip#<s>2#",
					"for each card {C:attention}purchased{}",
					"{C:inactive}(現在 {C:chips}+#1#{C:inactive} Chip#<s>1#)",
				},
			},
			j_cry_cut = {
				name = "Cut",
				text = {
					"This Joker destroys",
					"a random {C:cry_code}Code{} card",
					"to gain 倍率 {X:mult,C:white} X#1# {}",
					"at the end of the {C:attention}shop{}",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_delirious = {
				name = "Delirious Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_demicolon = {
				name = "Demicolon",
				text = {
					"{C:attention}Force-trigger{} the Joker",
					"to the right",
				},
			},
			j_cry_starfruit = {
				name = "Starfruit",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{},",
					"loses {X:dark_edition,C:white}^#2#{} Mult per",
					"{C:attention}reroll{} in the shop",
				},
			},
			j_cry_digitalhallucinations = {
				name = "Digital Hallucinations",
				text = {
					"When a {C:attention}ブースターパック{} is opened,",
					"{C:green}#1# in #2#{} chance to create",
					"a random {C:dark_edition}ネガティブ{} card",
					"corresponding to its {C:attention}type{}",
				},
			},
			j_cry_discreet = {
				name = "Discreet Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"チップ {C:red}+#1#{}",
				},
			},
			j_cry_doodlem = {
				name = "Doodle M",
				text = {
					"Create #2# {C:dark_edition}ネガティブ{} {C:attention}consumables{}",
					"when {C:attention}ブラインド{} is selected",
					"Create #1# more {C:attention}consumable",
					"for each {C:attention}Jolly Joker{}",
				},
			},
			["j_cry_Double Scale"] = { -- ?????????????
				name = "Double Scale",
				text = {
					"Whenever a {C:attention}Joker scales{}",
					"The {C:attention}scaling rate{} is increased by its {C:attention}original scale rate{}",
					"{C:inactive,s:0.8}(Does not stack with copies of this Joker){}",
					"{C:inactive,s:0.8}(ex. +1, +3, +6, +10)",
					"{C:inactive,s:0.8}(grows by +1, +2, +3)",
				},
			},
			["j_cry_Double Scale_modest"] = {
				name = "Double Scale",
				text = {
					"Scaling {C:attention}Jokers{}",
					"scale {C:attention}twice{} as fast",
					'{C:inactive,s:0.8}"It\'s called double scale, not quadratic scale!"',
				},
			},
			j_cry_dropshot = {
				name = "Dropshot",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {} for",
					"each played, {C:attention}nonscoring{} {V:1}#2#{} card,",
					"suit changes every round",
					"{C:inactive}(現在 {X:mult,C:white} X#3# {C:inactive} Mult)",
				},
				unlock = {
					"{C:attention}ハイカード{}と共に",
					"スコアされない{C:attention}同じスート{}の",
					"{C:attention}4{}枚のカードをプレイする",
				},
			},
			j_cry_dubious = {
				name = "Dubious Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"チップ {C:red}+#1#{}",
				},
			},
			j_cry_duos = {
				name = "The Duos",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"{C:attention}ツーペア{}をプレイせずに",
					"ランに勝利する",
				},
			},
			j_cry_duplicare = {
				name = "Duplicare",
				text = {
					"This Joker gains {X:mult,C:white} X#2# {} Mult",
					"when a {C:attention}Joker{} or",
					"トランプ is scored",
					"{C:inactive}(現在 {X:mult,C:white} X#1# {C:inactive} Mult)",
				},
			},
			j_cry_effarcire = {
				name = "イファリシア",
				text = {
					"{C:attention}ブラインド{}が選択された時",
					"{C:green}デッキ内すべてのカード{}を手札に加える",
					"{C:inactive,s:0.8}\"もしあなたが私が1枚の時にきちんと扱ってくれないなら、",
					"{C:inactive,s:0.8}私を2枚扱う資格はない。\"",
				},
			},
			j_cry_energia = {
				name = "Energia",
				text = {
					"When a {C:attention}タグ{} is acquired,",
					"create up to {C:attention}#1#{} cop#<ies,y>1# of it",
					"and {C:attention}increase{} the number of",
					"copies by {C:attention}#2#",
				},
			},
			j_cry_equilib = {
				name = "Ace Aequilibrium",
				text = {
					"Jokers appear using the",
					"order from the {C:attention}Collection{}",
					"Create {C:attention}#1#{} {C:dark_edition}ネガティブ{} Joker#<s>1#",
					"when hand is played",
					"{C:cry_exotic,s:0.8}Exotic {C:inactive,s:0.8}or better Jokers cannot appear",
					"{s:0.8}Last Joker Generated: {C:attention,s:0.8}#2#",
				},
			},
			j_cry_error = {
				name = "{C:red}ERR{}{C:dark_edition}O{}{C:red}R{}",
				text = {
					"",
				},
			},
			j_cry_eternalflame = {
				name = "Eternal Flame",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"for each card {C:attention}sold{} with",
					"at least {C:money}$3{} of {C:attention}sell value",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_eternalflame2 = {
				name = "Eternal Flame",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"for each card {C:attention}sold{}",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_exoplanet = {
				name = "Exoplanet",
				text = {
					"Other {C:dark_edition}Holographic{} cards",
					"each give {C:mult}+#1#{} Mult",
				},
			},
			j_cry_exponentia = {
				name = "Exponentia",
				text = {
					"This Joker gains {X:dark_edition,C:white}  #1# {} Mult",
					"when {X:red,C:white} XMult {} is triggered",
					"{C:inactive}(現在 倍率 {X:dark_edition,C:white} #2#乗 {C:inactive})",
				},
			},
			j_cry_exposed = {
				name = "Exposed",
				text = {
					"Retrigger all scored non-{C:attention}face{} cards",
					"{C:attention}#1#{} additional time#<s>1#",
					"All {C:attention}face{} cards are debuffed",
				},
			},
			j_cry_eyeofhagane = {
				name = "Eye of Hagane",
				text = {
					"All played {C:attention}face{} cards",
					"become {C:attention}Steel{} cards",
					"when scored",
				},
			},
			j_cry_highfive = {
				name = "High Five",
				text = {
					"If highest {C:attention}scoring rank{}",
					"is {C:attention}5{}, convert {C:attention}all{} scoring cards",
					"into {C:attention}5{}s",
					"{s:0.8,C:inactive}Aces are considered 1",
				},
			},
			j_cry_facile = {
				name = "Facile",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{} if",
					"played cards are scored",
					"{C:attention}#2#{} or fewer times",
				},
			},
			j_cry_familiar_currency = {
				name = "Familiar Currency",
				text = {
					"Create a {C:attention}Meme Joker{}",
					"at the end of round",
					"for {C:money}$#1#{} {C:inactive}(if possible)",
					"{C:inactive}(Must have room)",
				},
			},
			j_cry_filler = {
				name = "The Filler",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"{C:attention}ハイカード{}をプレイせずに",
					"ランに勝利する",
				},
			},
			j_cry_fractal = {
				name = "Fractal Fingers",
				text = {
					"{C:attention}+#1#{} card selection limit",
				},
				unlock = {
					"Play a {C:attention}Straight Flush{}",
					"without the {C:attention}Straight",
					"being a {C:attention}Flush",
				},
			},
			j_cry_flip_side = {
				name = "On the Flip Side",
				text = {
					"{C:dark_edition}両面{} Jokers use",
					"their back side for effects",
					"instead of the front side",
					"{C:attention}Retrigger{} all {C:dark_edition}両面{} Jokers",
				},
			},
			j_cry_foodm = {
				name = "Fast Food M",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:red,E:2}self destructs{} in {C:attention}#2#{} round#<s>2#",
					"Increases by {C:attention}#3#{} round when",
					"{C:attention}Jolly Joker{} is {C:attention}sold{}",
					"{C:inactive,s:0.8}2 McDoubles, 2 McChickens{}",
					"{C:inactive,s:0.8}Large Fries, 20 Piece & Large Cake{}",
				},
			},
			j_cry_foolhardy = {
				name = "Foolhardy Joker",
				text = {
					"{C:red}+#1#{} Mult if played",
					"hand contains",
					"an {C:attention}#2#",
				},
			},
			j_cry_undefined = {
				name = "Undefined Joker",
				text = {
					"{C:red}+#1#{} Mult if played",
					"hand is {C:attention}#2#",
				},
			},
			j_cry_formidiulosus = {
				name = "フォルミドゥロサス",
				text = {
					"{X:cry_cursed,C:white}呪い{}ジョーカーを得た時 それを破壊する",
					"ショップから出た時 {C:attention}#1#個{}の{C:dark_edition}ネガティブ{C:cry_candy}キャンディを作成する",
					"所持する{C:cry_candy}キャンディ{}1つにつき 倍率 {X:dark_edition,C:white}#2#乗{}",
					"{C:inactive}(現在 倍率 {X:dark_edition,C:white}#3#乗{C:inactive})",
				},
			},
			j_cry_foxy = {
				name = "Foxy Joker",
				text = {
					"プレイしたハンドが",
                                        "{C:attention}#2#{} を含む場合",
					"チップ {C:chips}+#1#{}",
				},
			},
			j_cry_fspinner = {
				name = "Fidget Spinner",
				text = {
					"This Joker gains {C:chips}+#2#{} Chip#<s>2#",
					"if hand played is {C:attention}not{}",
					"most played {C:attention}ポーカーハンド{}",
					"{C:inactive}(現在 {C:chips}+#1#{C:inactive} Chip#<s>1#)",
				},
			},
			j_cry_fuckedup = {
				name = Cryptid_config.family_mode and "Tidy Joker" or "Fucked-Up Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_gardenfork = {
				name = "Garden of Forking Paths",
				text = {
					"Earn {C:money}$#1#{} if {C:attention}played hand{}",
					"contains an {C:attention}Ace{} and a {C:attention}7{}",
				},
			},
			j_cry_gemino = {
				name = "Gemini",
				text = {
					"{C:attention}Double{} all values",
					"of leftmost {C:attention}Joker",
					"at end of round",
				},
			},
			j_cry_ghost = {
				name = "ゴースト",
				text = {
					"ラウンド終了時",
					"{C:green}#3#分の#1#{} の確率で",
					"ランダムな{C:attention}ジョーカー{}に {C:attention}憑依{}する",
					"{C:green}#4#分の#2#{} の確率で",
					"{E:2,C:red}自身を破壊する",
				},
			},
			j_cry_giggly = {
				name = "Absurd Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_goldjoker = {
				name = "Gold Joker",
				text = {
					"Earn {C:money}#1#%{} of total",
					"money at end of round",
					"Payout increases by {C:money}#2#%{}",
					"when each played {C:attention}Gold{}",
					"card is scored",
				},
			},
			j_cry_googol_play = {
				name = "Googol Play Card",
				text = {
					"{C:green}#1# in #2#{} chance for",
					"{X:red,C:white} X#3# {} Mult",
				},
				unlock = {
					"Score {C:attention}1.0e100{} Chips",
					"in a single hand",
				},
			},
			j_cry_happy = {
				name = ":D",
				text = {
					"Create a random {C:attention}Joker{}",
					"at end of round",
					"Sell this card to",
					"create a random {C:attention}Joker{}",
					"{C:inactive}(空きが必要){}",
				},
			},
			j_cry_happyhouse = {
				name = "Happy House",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{} only after",
					"playing {C:attention}#3#{} hands{}",
					"{C:inactive}(現在 #2#/#3#){}",
					"{C:inactive,s:0.8}There is no place like home!{}",
				},
			},
			j_cry_home = {
				name = "The Home",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"{C:attention}フルハウス{}をプレイせずに",
					"ランに勝利する",
				},
			},
			j_cry_hunger = {
				name = "Consume-able",
				text = {
					"Earn {C:money}$#1#{} when",
					"using a {C:attention}consumable{}",
				},
			},
			j_cry_huntingseason = {
				name = "Hunting Season",
				text = {
					"If played hand contains exactly {C:attention}3{} cards,",
					"{C:red}destroy{} the {C:attention}center{} card after scoring",
				},
			},
			j_cry_iterum = {
				name = "Iterum",
				text = {
					"Retrigger all cards played",
					"{C:attention}#2#{} time#<s>2#,",
					"each played card gives",
					"倍率 {X:mult,C:white} X#1# {} when scored",
					"{C:inactive}(Max {}{C:attention}#3#{}{C:inactive} retriggers)",
				},
			},
			j_cry_jawbreaker = {
				name = "Jawbreaker",
				text = {
					"When {C:attention}ボスブラインド{} defeated,",
					"{C:attention}double{} values of adjacent Jokers",
					"{E:2,C:red}self destructs{}",
				},
			},
			j_cry_jimball = {
				name = "Jimball",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"per {C:attention}consecutive{} hand played",
					"while playing your",
					"most played {C:attention}ポーカーハンド",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
				unlock = {
					"Win a run",
					"while playing a",
					" {C:attention}single type of{}",
					"{C:attention}ポーカーハンド",
				},
			},
			j_cry_jollysus = {
				name = "Jolly Joker?",
				text = {
					"Create a {C:dark_edition}Jolly{} Joker",
					"when a Joker is {C:attention}sold{}",
					"{C:red}Works once per round{}",
					"{C:inactive}#1#{}",
					"{C:inactive,s:0.8}Seems legit...{}",
				},
			},
			j_cry_jtron = {
				name = "Jimbo-tron 9000",
				text = {
					"This Joker gains {X:dark_edition,C:white} ^#1# {} Mult",
					"for each default {C:attention}Joker{}",
					"{C:inactive}(現在 {X:dark_edition,C:white}^#2#{C:inactive} Mult)",
				},
			},
			j_cry_kidnap = {
				name = "Kidnapping",
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"per unique {C:attention}Type Mult{} or",
					"{C:attention}Type Chips{} Joker sold this run",
					"{C:inactive}(現在 {C:money}$#2#{C:inactive})",
				},
			},
			j_cry_kittyprinter = {
				name = "Kitty Printer",
				text = {
					"倍率 {X:mult,C:white} X#1# {}",
					"All {C:attention}skip{} tags",
					"become {C:attention}Cat タグ{}",
				},
			},
			j_cry_kooky = {
				name = "Kooky Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_krustytheclown = {
				name = "Krusty the Clown",
				text = {
					"This Joker gains",
					"倍率 {X:mult,C:white} X#1# {} when",
					"each played {C:attention}card{} is scored",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_kscope = {
				name = "Kaleidoscope",
				text = {
					"Add {C:dark_edition}Polychrome{} to",
					"a random {C:attention}Joker{} when",
					"{C:attention}ボスブラインド{} is defeated",
				},
				unlock = {
					"Defeat a {C:attention}ボスブラインド",
					"with {C:attention}5{} or more",
					"{C:attention}Editioned Cards{} or",
					"{C:attention}Jokers",
				},
			},
			j_cry_lebaron_james = {
				name = "LeBaron James",
				text = {
					"Played and scoring {C:attention}Kings{} give",
					"{C:attention}+#1#{} hand size for the round",
					"and trigger {C:attention}held in hand{} effects",
					"{C:inactive}(現在 {}{C:attention}+#2#{}{C:inactive})",
				},
			},
			j_cry_lightupthenight = {
				name = "Light Up the Night",
				text = {
					"Each played {C:attention}7{} or {C:attention}2{}",
					"gives {X:mult,C:white}X#1#{} Mult when scored",
				},
			},
			j_cry_longboi = {
				name = "Monster",
				text = {
					"Give future copies of",
					"this Joker {X:mult,C:white}X#1#{} Mult",
					"at end of round",
					"{C:inactive}(現在 {X:mult,C:white}X#2#{C:inactive} Mult){}",
				},
			},
			j_cry_loopy = {
				name = "Loopy",
				text = {
					"{C:attention}Retrigger{} all Jokers",
					"once for each {C:attention}Jolly{}",
					"{C:attention}Joker{} sold this round",
					"{C:inactive}(現在{}{C:attention} #1#{}{C:inactive} retrigger#<s>1#){}",
					"{C:inactive,s:0.8}There wasn't enough room...{}",
				},
			},
			j_cry_lucky_joker = {
				name = "Lucky Joker",
				text = {
					"Earn {C:money}$#1#{} every time a",
					"{C:attention}Lucky{} card {C:green}successfully{}",
					"triggers",
				},
			},
			j_cry_luigi = {
				name = "Luigi",
				text = {
					"All Jokers give",
					"{X:chips,C:white} X#1# {} Chips",
				},
			},
			j_cry_m = {
				name = "m",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"when {C:attention}Jolly Joker{} is sold",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_M = {
				name = "M",
				text = {
					"Create a {C:dark_edition}ネガティブ{}",
					"{C:attention}Jolly Joker{} when",
					"{C:attention}ブラインド{} is selected",
				},
			},
			j_cry_macabre = {
				name = "Macabre Joker",
				text = {
					"When {C:attention}ブラインド{} is selected,",
					"destroys each {C:attention}Joker{} except",
					"{C:legendary}M Jokers{} and {C:attention}Jolly Jokers{}",
					"and create #1# {C:attention}Jolly Joker#<s>1#{}",
					"for each destroyed card",
				},
			},
			j_cry_magnet = {
				name = "Fridge Magnet",
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"This earns {X:money,C:white} X#2# {} if there are",
					"{C:attention}#3#{} or fewer {C:attention}Joker{} cards",
				},
			},
			j_cry_manic = {
				name = "Manic Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_mario = {
				name = "Mario",
				text = {
					"Retrigger all Jokers",
					"{C:attention}#1#{} additional time#<s>1#",
				},
			},
			j_cry_mask = {
				name = "Mask",
				text = {
					"Retrigger all scored {C:attention}face{} cards",
					"{C:attention}#1#{} additional time#<s>1#",
					"All non-{C:attention}face{} cards are debuffed",
				},
			},
			j_cry_maximized = {
				name = "Maximized",
				text = {
					"All {C:attention}face{} cards",
					"are considered {C:attention}Kings{},",
					"all {C:attention}numbered{} cards",
					"are considered {C:attention}10s{}",
				},
				unlock = {
					"Play a {C:attention}Flush Five{}",
					"of {C:attention}Kings",
				},
			},
			j_cry_maze = {
				name = "Labyrinth",
				text = {
					"All hands are considered the",
					"{C:attention}first hand{} of each round,",
					"all ディスカード are considered the",
					"{C:attention}first ディスカード{} of each round",
				},
			},
			j_cry_megg = {
				name = "Megg",
				text = {
					"Sell this card to create",
					"{C:attention}#2#{} Jolly #3#, increase", -- huh
					"by {C:attention}#1#{} at end of round",
				},
			},
			j_cry_mellowcreme = {
				name = "Mellowcreme",
				text = {
					"Sell this card to {C:attention}multiply",
					"the sell value of all",
					"{C:attention}consumables{} by {C:attention}X#1#",
				},
			},
			j_cry_membershipcard = {
				name = "Membership Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult for each member",
					"in the {C:attention}Cryptid Discord{}",
					"{C:inactive}(現在 {X:mult,C:white}X#2#{C:inactive} Mult)",
					"{C:blue,s:0.7}https://discord.gg/eUf9Ur6RyB{}",
				},
			},
			j_cry_membershipcardtwo = {
				name = "Old Membership Card", --Could probably have a diff Name imo
				text = {
					"{C:chips}+#1#{} Chip#<s>1# for each member",
					"in the {C:attention}Cryptid Discord{}",
					"{C:inactive}(現在 {C:chips}+#2#{C:inactive} Chip#<s>2#)",
					"{C:blue,s:0.7}https://discord.gg/eUf9Ur6RyB{}",
				},
			},
			j_cry_membershipcardtwo_balanced = {
				name = "Old Membership Card", --Could probably have a diff Name imo
				text = {
					"{C:chips}+#1#{} Chip#<s>1# for every {C:attention}8{} members",
					"in the {C:attention}Cryptid Discord{}",
					"{C:inactive}(現在 {C:chips}+#2#{C:inactive} Chip#<s>2#)",
					"{C:blue,s:0.7}https://discord.gg/eUf9Ur6RyB{}",
				},
			},
			j_cry_meteor = {
				name = "Meteor Shower",
				text = {
					"Other {C:dark_edition}Foil{} cards each",
					"give {C:chips}+#1#{} Chip#<s>1#",
				},
			},
			j_cry_mneon = {
				name = "Neon M",
				text = {
					"Earn {C:money}$#2#{} at end of round",
					"Increase payout by",
					"{C:money}$#1#{} for each {C:attention}Jolly Joker{}",
					"or {C:legendary}M Joker{} at",
					"end of round",
				},
			},
			j_cry_mondrian = {
				name = "Mondrian",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"if no {C:attention}ディスカード{} were",
					"used this round",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_monkey_dagger = {
				name = "Monkey Dagger",
				text = {
					"When {C:attention}ブラインド{} is selected,",
					"destroy Joker to the left",
					"and permanently add {C:attention}ten times{}",
					"its sell value to this {C:chips}Chips{}",
					"{C:inactive}(現在 {C:chips}+#1#{C:inactive} Chip#<s>1#)",
				},
			},
			j_cry_monopoly_money = {
				name = "Monopoly Money",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"{C:attention}destroy{} purchased items",
					"Halves money when {C:attention}sold",
				},
			},
			j_cry_morse = {
				name = "Morse Code",
				text = {
					"Earn {C:money}$#2#{} at end of round",
					"Increase payout by {C:money}$#1#{} when",
					"a card with an {C:attention}Edition{} is sold",
				},
			},
			j_cry_mprime = {
				name = "Tredecim",
				text = {
					"Create an {C:legendary}M Joker{} at end of round",
					"Each {C:attention}Jolly Joker{} or {C:legendary}M Joker",
					"gives 倍率 {X:dark_edition,C:white}#1#乗{}",
					"Increase amount by {X:dark_edition,C:white}^#2#{}",
					"when a {C:attention}Jolly Joker{} is {C:attention}sold",
					"{C:inactive,s:0.8}(Tredecim excluded)",
				},
			},
			j_cry_mstack = {
				name = "M Stack",
				text = {
					"Retrigger all cards played",
					"once for every",
					"{C:attention}#2#{} {C:inactive}[#3#]{} {C:attention}Jolly Joker#<s>2#{} sold",
					"{C:inactive}(現在{}{C:attention} #1#{}{C:inactive} retriggers){}",
				},
			},
			j_cry_multjoker = {
				name = "Mult Joker",
				text = {
					"{C:green}#1# in #2#{} chance for each",
					"played {C:attention}Mult{} card to create",
					"a {C:spectral}Cryptid{} card when scored",
					"{C:inactive}(Must have room)",
				},
			},
			j_cry_necromancer = {
				name = "Necromancer",
				text = {
					"When a Joker is {C:attention}sold{} for more than {C:attention}#1#{},",
					"gain a {C:attention}random{} Joker {C:attention}sold{} this run",
					"with {C:money}#1#{} sell value",
				},
			},
			j_cry_negative = {
				name = "ネガティブジョーカー",
				text = {
					"{C:attention}ジョーカー{}スロット {C:dark_edition}+#1#",
				},
			},
			j_cry_nice = {
				name = "Nice",
				text = {
					"プレイされたハンドに",
					"1枚の{C:attention}6{}と1枚の{C:attention}9{}が含まれている場合",
					"チップ{C:chips}+#1#{}",
					"{C:inactive,s:0.8}Nice.{}",
				},
			},
			j_cry_night = {
				name = "夜",
				text = {
					"ラウンドの 最終ハンド で",
					"倍率 {X:dark_edition,C:white}#1#乗{}",
					"その後 {E:2,C:red}自身を破壊する{}",
				},
			},
			j_cry_nosound = {
				name = "No Sound, No Memory",
				text = {
					"Retrigger each played {C:attention}7{}",
					"{C:attention}#1#{} additional time#<s>1#",
				},
			},
			j_cry_notebook = {
				name = "Motebook",
				text = {
					"{C:green} #1# in #2#{} chance to gain {C:dark_edition}+#6#{} Joker",
					"slot#<s>6# per {C:attention}reroll{} in the shop",
					"{C:green}Always triggers{} if there are",
					"{C:attention}#5#{} or more {C:attention}Jolly Jokers{}",
					"{C:red}Works once per round{}",
					"{C:inactive}(現在 {C:dark_edition}+#3#{}{C:inactive} and #4#){}",
				},
			},
			j_cry_number_blocks = {
				name = "Number Blocks",
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"Increase payout by {C:money}$#2#{}",
					"for each {C:attention}#3#{} held in hand,",
					"rank changes every round",
				},
			},
			j_cry_nuts = {
				name = "The Nuts",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"{C:attention}ストレートフラッシュ{}をプレイせずに",
					"ランに勝利する",
				},
			},
			j_cry_nutty = {
				name = "Nutty Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_oil_lamp = {
				name = "Oil Lamp",
				text = {
					"Increase values of {C:attention}Joker{} to the right",
					"by {C:attention}X#1#{} at end of round",
				},
			},
			j_cry_oldblueprint = {
				name = "Old Blueprint",
				text = {
					"Copies ability of",
					"{C:attention}Joker{} to the right",
					"{C:green}#1# in #2#{} chance this",
					"card is destroyed",
					"at end of round",
				},
			},
			j_cry_oldcandy = {
				name = "Nostalgic Candy",
				text = {
					"Sell this card to",
					"permanently gain",
					"{C:attention}+#1#{} hand size",
				},
			},
			j_cry_oldinvisible = {
				name = "Nostalgic Invisible Joker",
				text = {
					"{C:attention}Duplicate{} a random",
					"{C:attention}Joker{} every {C:attention}4",
					"Joker cards sold",
					"{s:0.8}Nostalgic Invisible Joker Excluded{}",
					"{C:inactive}(現在 #1#/4){}",
				},
			},
			j_cry_panopticon = {
				name = "Panopticon",
				text = {
					"All hands are considered the",
					"{C:attention}last hand{} of each round", -- +$4
				},
			},
			j_cry_penetrating = {
				name = "Penetrating Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"チップ {C:red}+#1#{}",
				},
			},
			j_cry_pickle = {
				name = "ピクルス",
				text = {
					"{C:attention}ブラインド{}がスキップされた時",
					"{C:attention}#1#{}個のタグを作成する",
					"{C:attention}ブラインド{}を選択すると", 
					"作成数を {C:red}#2#{} 減少させる",
				},
			},
			j_cry_pirate_dagger = {
				name = "Pirate Dagger",
				text = {
					"When {C:attention}ブラインド{} is selected,",
					"destroy Joker to the right",
					"and gain {C:attention}one-fourth{} of",
					"its sell value as {X:chips,C:white} XChips {}",
					"{C:inactive}(現在 {X:chips,C:white} X#1# {C:inactive} Chips)",
				},
			},
			j_cry_pity_prize = {
				name = "Pity Prize",
				text = {
					"On skipping a {C:attention}ブースターパック{},",
					"gain a random {C:attention}タグ{}",
				},
			},
			j_cry_pity_prize_modest = {
				name = "Pity Prize",
				text = {
					"On skipping a {C:attention}ブースターパック{},",
					"gain a random {C:attention}タグ{}",
					"{C:red,E:2}Self destructs{}",
				},
			},
			j_cry_pot_of_jokes = {
				name = "Pot of Jokes",
				text = {
					"{C:attention}#1#{} hand size,",
					"increases by",
					"{C:blue}#2#{} every round",
					"{C:inactive}(Maximum {}{C:attention}#3#{}{C:inactive} hand size){}",
				},
				unlock = {
					"Increase your {C:attention}handsize",
					"to {C:attention}12",
				},
			},
			j_cry_primus = {
				name = "プリムス",
				text = {
					"プレイされたハンドが",
					"{C:attention}A{}、{C:attention}2{}、{C:attention}3{}、{C:attention}5{}、{C:attention}7{}のみで構成されている場合",
					"倍率 {X:dark_edition,C:white} #1#乗 {} を得る",
					"{C:inactive}(現在 倍率 {X:dark_edition,C:white} #2#乗 {C:inactive})",
				},
			},
			j_cry_pumpkin = {
				name = "Pumpkin",
				text = {
					"Prevents Death if chips scored",
					"are atleast {C:attention}50%{} of required chips",
					"{C:attention}Turns into Carved Pumpkin",
					"{C:attention}when{} {C:red}destroyed",
				},
			},
			j_cry_carved_pumpkin = {
				name = "Carved Pumpkin",
				text = {
					"The next {C:attention}#1#{} ボスブラインド",
					"will have their abilities",
					"{C:attention}disabled",
				},
			},
			j_cry_python = {
				name = "Python",
				text = {
					"This Joker gains",
					"倍率 {X:mult,C:white} X#1# {} when a",
					"{C:cry_code}Code{} card is used",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_queens_gambit = {
				name = "Queen's Gambit",
				text = {
					"If {C:attention}ポーカーハンド{} is a",
					"{C:attention}Royal Flush{}, destroy scored",
					"{C:attention}Queen{} and create a",
					"{C:dark_edition}ネガティブ {}{C:red}Rare{}{C:attention} Joker{}",
				},
			},
			j_cry_quintet = {
				name = "The Quintet",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}Five of a Kind",
				},
			},
			j_cry_redbloon = {
				name = "Red Bloon",
				text = {
					"Earn {C:money}$#1#{} in {C:attention}#2#{} round#<s>2#",
					"{C:red,E:2}self destructs{}",
				},
			},
			j_cry_redeo = {
				name = "Redeo",
				text = {
					"{C:attention}-#1#{} アンティ when",
					"{C:money}$#2#{} {C:inactive}($#3#){} spent",
					"{s:0.8}Requirements increase",
					"{C:attention,s:0.8}exponentially{s:0.8} per use",
					"{C:money,s:0.8}Next increase: {s:1,c:money}$#4#",
				},
			},
			j_cry_rescribere = {
				name = "Rescribere",
				text = {
					"When a {C:attention}Joker{} is sold,",
					"add its effects to",
					"every other Joker",
					"{C:inactive,s:0.8}Does not affect other Rescribere{}",
				},
			},
			j_cry_reverse = {
				name = "Reverse Card",
				text = {
					"Fill all empty Joker slots {C:inactive}(Max 100){}",
					"with {C:dark_edition}Holographic{} {C:attention}Jolly Jokers{} if",
					"{C:attention}discarded ポーカーハンド{} is a {C:attention}#1#{}",
					"{C:red,E:2}self destructs{}",
					"{C:inactive,s:0.8}The ULTIMATE comeback{}",
				},
			},
			j_cry_rnjoker = {
				name = "RNJoker",
				text = {
					"Randomize abilities each {C:attention}アンティ{}",
				},
				unlock = {
					"{C:green}1 in 20{} chance",
					"to unlock this card",
					"on {C:attention}Game Over",
				},
			},
			j_cry_sacrifice = {
				name = "Sacrifice",
				text = {
					"Create #3# {C:green}Uncommon{} Joker#<s>3#",
					"and #2# {C:attention}Jolly Joker#<s>2#{} when",
					"a {C:spectral}Spectral{} card is used",
					"{C:red}Works once per round{}",
					"{C:inactive}#1#{}",
				},
			},
			j_cry_sapling = {
				name = "Sapling",
				text = {
					"After scoring {C:attention}#2#{} {C:inactive}[#1#]{} Enhanced",
					"cards, sell this card to",
					"create #4# {V:1}#3#{} {C:attention}Joker{}",
				},
			},
			j_cry_savvy = {
				name = "Savvy Joker",
				text = {
					"プレイしたハンドが",
                                        "{C:attention}#2#{} を含む場合",
					"チップ {C:chips}+#1#{}",
				},
			},
			j_cry_Scalae = {
				name = "階段",
				text = {
					"成長する{C:attention}ジョーカー{}の増分は",
					"{C:attention}#1#{}次多項式としてスケールし",
					"ラウンド終了時にその次数を{C:attention}#2#{} 増やす",
					"{C:inactive,s:0.8}({C:attention,s:0.8}階段{C:inactive,s:0.8} は除く)",
					"{C:inactive,s:0.8}(例: +1, +#3#, +#4#, +#5#)",
				},
			},
			j_cry_scrabble = {
				name = "Scrabble Tile",
				text = {
					"{C:green}#1# in #2#{} chance to create",
					"a {C:dark_edition}Jolly {C:green}Uncommon{} Joker",
					"when hand is played",
				},
			},
			j_cry_seal_the_deal = {
				name = "Seal the Deal",
				text = {
					"Add a {C:attention}random seal{} to each card",
					"scored on {C:attention}final hand{} of round",
				},
			},
			j_cry_shrewd = {
				name = "Shrewd Joker",
				text = {
					"プレイしたハンドが",
                                        "{C:attention}#2#{} を含む場合",
					"チップ {C:chips}+#1#{}",
				},
			},
			j_cry_silly = {
				name = "Silly Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_smallestm = {
				name = "Tiny",
				text = {
					"Create a {C:cry_jolly}Double M",
					"tag if {C:attention}ポーカーハンド{}",
					"is a {C:attention}#1#{}",
					"{C:inactive,s:0.8}ok so basically i'm very smol",
				},
			},
			j_cry_soccer = {
				name = "One for All", --changed the name from latin because this isn't exotic
				text = {
					"{C:attention}+#1#{} Joker slot#<s>1#",
					"{C:attention}+#1#{} Booster Pack slot#<s>1#",
					"{C:attention}+#1#{} hand size",
					"{C:attention}+#1#{} consumable slot#<s>1#",
					"{C:attention}+#1#{} card#<s>1# in shop",
					"{C:attention}+#1#{} バウチャー slot#<s>1#",
				},
				unlock = {
					"Win a run with",
					"only {C:attention}High Card",
				},
			},
			j_cry_soccer_balanced = {
				name = "One for All", --changed the name from latin because this isn't exotic
				text = {
					"{C:attention}+#1#{} Booster Pack slot#<s>1#",
					"{C:attention}+#1#{} hand size",
					"{C:attention}+#1#{} consumable slot#<s>1#",
					"{C:attention}+#1#{} card#<s>1# in shop",
					"{C:attention}+#1#{} バウチャー slot#<s>1#",
				},
				unlock = {
					"Win a run with",
					"only {C:attention}High Card",
				},
			},
			j_cry_fleshpanopticon = {
				name = "Flesh Panopticon",
				text = {
					"{C:red}X#1#{} {C:attention}ボスブラインド{} size",
					"When {C:attention}ボスブラインド{} is defeated,",
					"{C:red}self destructs{}, and creates",
					"a {C:dark_edition}ネガティブ{} {C:spectral}Gateway{} card",
					'{C:inactive,s:0.8}"This prison... to hold... me?"',
				},
			},
			j_cry_sock_and_sock = {
				name = "Sock and Sock",
				text = {
					"Retrigger all played",
					"{C:attention}Abstract{} cards {C:attention}#1#{} time#<s>1#",
				},
			},
			j_cry_brokenhome = {
				name = "Broken Home",
				text = {
					"倍率 {X:mult,C:white} X#1# {}",
					"{C:green}#2# in #3#{} chance this",
					"card is destroyed",
					"at end of round",
				},
			},
			j_cry_yarnball = {
				name = "Yarn Ball",
				text = {
					"Add the level of the highest level {C:attention}Cat タグ{}",
					"to all {C:green}listed probabilities",
				},
			},
			j_cry_pizza = {
				name = "Pizza",
				text = {
					"After {C:attention}#1#{} {C:inactive}[#2#]{} round#<s>1#",
					"sell this Joker to create",
					"{C:attention}#3#{} Pizza Slices",
				},
			},
			j_cry_pizza_slice = {
				name = "Pizza Slice",
				text = {
					"This Joker gains {X:mult,C:white}X#1#{} Mult",
					"when a {C:attention}Pizza Slice{} is sold",
					"{C:inactive}(現在{} {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
				},
			},
			j_cry_paved_joker = {
				name = "Paved Joker",
				text = {
					"Stone Cards may fill",
					"gaps of {C:attention}#1#{} in",
					"{C:attention}Straights{} and {C:attention}Flushes{}",
				},
			},
			j_cry_fading_joker = {
				name = "Fading Joker",
				text = {
					"This Joker Gains",
					"{X:mult,C:white}X#1#{} Mult whenever",
					"a {C:attention}生モノ{} card is debuffed",
					"{C:inactive}(現在{} {X:mult,C:white}X#2#{} {C:inactive}Mult){}",
				},
			},
			j_cry_poor_joker = {
				name = "Poor Joker",
				text = {
					"This Joker gains",
					"{C:mult}+#1#{} Mult whenever",
					"a {C:attention}Rental{} card takes money",
					"{C:inactive}(現在{} {C:mult}+#2#{} {C:inactive}Mult){}",
				},
			},
			j_cry_spaceglobe = {
				name = "Celestial Globe",
				text = {
					"This Joker gains {X:chips,C:white}X#2#{} Chips",
					"if {C:attention}ポーカーハンド{} is a {C:attention}#3#{},",
					"Hand changes after increase{}",
					"{C:inactive}(現在{} {X:chips,C:white}X#1#{} {C:inactive}Chips){}",
				},
			},
			j_cry_spectrogram = {
				name = "Spectrogram",
				text = {
					"{C:attention}Retriggers{} rightmost Joker",
					"once for every {C:attention}Echo Card",
					"that is played and scored",
				},
			},
			j_cry_speculo = {
				name = "Speculo",
				text = {
					"Creates a {C:dark_edition}ネガティブ{} copy",
					"of a random {C:attention}Joker{}",
					"at the end of the {C:attention}shop",
					"{C:inactive,s:0.8}Does not copy other Speculo{}",
				},
			},
			j_cry_spy = {
				name = "Spy",
				text = {
					"{X:mult,C:white} X#2# {} Mult, {C:dark_edition}+1{C:attention} Joker{} slot",
					"{C:inactive}That #1# is a spy!",
				},
			},
			j_cry_stardust = {
				name = "Stardust",
				text = {
					"Other {C:dark_edition}Polychrome{} cards",
					"each give {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_cry_stella_mortis = {
				name = "Stella Mortis",
				text = {
					"This Joker destroys a",
					"random {C:planet}Planet{} card",
					"to gain {X:dark_edition,C:white} ^#1# {} Mult",
					"at the end of the {C:attention}shop{}",
					"{C:inactive}(現在 倍率 {X:dark_edition,C:white} #2#乗 {C:inactive})",
				},
			},
			j_cry_stronghold = {
				name = "The Stronghold",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}Bulwark",
				},
			},
			j_cry_subtle = {
				name = "Subtle Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"チップ {C:red}+#1#{}",
				},
			},
			j_cry_supercell = {
				name = "Supercell",
				text = {
					"{C:chips}+#1#{} Chip#<s>1#, {C:mult}+#1#{} Mult,",
					"{X:chips,C:white}X#2#{} Chips, {X:mult,C:white}X#2#{} Mult",
					"Earn {C:money}$#3#{} at",
					"end of round",
				},
			},
			j_cry_supercell_balanced = {
				name = "Supercell",
				text = {
					"{X:chips,C:white}X#2#{} Chips, {X:mult,C:white}X#2#{} Mult",
					"Earn {C:money}$#3#{} at",
					"end of round",
				},
			},
			j_cry_sus = {
				name = "SUS",
				text = {
					"At end of round, create",
					"a {C:attention}copy{} of a random",
					"card {C:attention}held in hand{},",
					"destroy all others",
					"{C:attention,s:0.8}Kings{s:0.8} of {C:hearts,s:0.8}Hearts{s:0.8} are prioritized",
				},
			},
			j_cry_swarm = {
				name = "The Swarm",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}Flush Five",
				},
			},
			j_cry_sync_catalyst = {
				name = "Sync Catalyst",
				text = {
					"Balances {C:chips}Chips{} and {C:mult}Mult{}",
					"{C:inactive,s:0.8}Hey! I've seen this one before!",
				},
			},
			j_cry_tax_fraud = {
				name = "Tax Fraud",
				text = {
					"Gain {C:attention}$#1#{} per {C:attention}Rental Joker",
					"at end of round",
				},
			},
			j_cry_tenebris = {
				name = "Tenebris",
				text = {
					"{C:dark_edition}+#1#{C:attention} Joker{} slot#<s>1#",
					"Earn {C:money}$#2#{} at end of round",
				},
			},
			j_cry_translucent = {
				name = "Translucent Joker",
				text = {
					"Sell this card to create",
					"a {C:attention}Banana 生モノ{} copy",
					"of a random {C:attention}Joker{}",
					"{s:0.8,C:inactive}(Copy bypasses perish compat)",
				},
			},
			j_cry_treacherous = {
				name = "Treacherous Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1# if played",
					"hand contains",
					"an {C:attention}#2#",
				},
			},
			j_cry_nebulous = {
				name = "Nebulous Joker",
				text = {
					"{C:chips}+#1#{} Chip#<s>1# if played",
					"hand is {C:attention}#2#",
				},
			},
			j_cry_words_cant_even = {
				name = "Words Can’t Even Begin to Describe This Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult if played",
					"hand contains",
					"a {C:attention}#2#",
				},
			},
			j_cry_many_lost_minds = {
				name = "Many Have Lost Their Minds Comprehending This Joker",
				text = {
					"チップ {C:chips}+#1#{} if played",
					"hand contains",
					"{C:attention}#2#",
				},
			},
			-- i wanted to correct this typo, but its not even used anywhere?? (well, except other localizations lol)
			j_cry_annihalation = {
				name = "The Complete and Utter Annihilation of Everything That Makes Balatro Sacred",
				text = {
					"倍率 {X:dark_edition,C:white}#1#乗{} if played",
					"hand contains",
					"a {C:attention}#2#",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}#1#",
				},
			},
			j_cry_trick_or_treat = {
				name = "Trick-or-Treat",
				text = {
					"When {C:attention}sold{}:",
					"{C:green}#1# in #2#{} chance to create {C:attention}#3#{} {C:cry_candy}Candies",
					"Otherwise, create a {X:cry_cursed,C:white}Cursed{} Joker",
					"{C:inactive}(Can overflow)",
				},
			},
			j_cry_tricksy = {
				name = "Tricksy Joker",
				text = {
					"プレイしたハンドが",
                                        "{C:attention}#2#{} を含む場合",
					"チップ {C:chips}+#1#{}",
				},
			},
			j_cry_triplet_rhythm = {
				name = "Triplet Rhythm",
				text = {
					"倍率 {X:mult,C:white} X#1# {} if scoring hand",
					"contains {C:attention}exactly{} three {C:attention}3s",
				},
			},
			j_cry_tropical_smoothie = {
				name = "Tropical Smoothie",
				text = {
					"Sell this card",
					"to {C:attention}multiply{} values",
					"of owned Jokers by {C:attention}X#1#{}",
				},
			},
			j_cry_unity = {
				name = "The Unity",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}Flush House",
				},
			},
			j_cry_universe = {
				name = "Universe",
				text = {
					"Other {C:dark_edition}Astral{} cards",
					"each give 倍率 {X:dark_edition,C:white}#1#乗{}",
				},
			},
			j_cry_universum = {
				name = "Universum",
				text = {
					"{C:attention}Poker hands{} gain",
					"{X:red,C:white} X#1# {} Mult and {X:blue,C:white} X#1# {} Chips",
					"when leveled up",
				},
			},
			j_cry_unjust_dagger = {
				name = "Unjust Dagger",
				text = {
					"When {C:attention}ブラインド{} is selected,",
					"destroy Joker to the left",
					"and gain {C:attention}one-fifth{} of",
					"its sell value as {X:mult,C:white} XMult {}",
					"{C:inactive}(現在 {X:mult,C:white} X#1# {C:inactive} Mult)",
				},
			},
			j_cry_verisimile = {
				name = "Non Verisimile",
				text = {
					"When any probability",
					"is {C:green}successfully{} triggered,",
					"this Joker gains {X:red,C:white}XMult{}",
					"equal to its listed {C:attention}odds",
					"{C:inactive}(現在 {X:mult,C:white} X#1# {C:inactive} Mult)",
				},
			},
			j_cry_virgo = {
				name = "Virgo",
				text = {
					"This Joker gains {C:money}$#1#{} of {C:attention}sell value{}",
					"if {C:attention}ポーカーハンド{} contains a {C:attention}#2#{}",
					"Sell this card to create a",
					"{C:dark_edition}Polychrome{} {C:attention}Jolly Joker{} for",
					"every {C:money}$4{} of {C:attention}sell value{} {C:inactive}(Min 1){}",
				},
			},
			j_cry_wacky = {
				name = "Wacky Joker",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}+#1#{}",
				},
			},
			j_cry_waluigi = {
				name = "Waluigi",
				text = {
					"All Jokers give",
					"倍率 {X:mult,C:white} X#1# {}",
				},
			},
			j_cry_wario = {
				name = "Wario",
				text = {
					"All Jokers give",
					"{C:money}$#1#{} when triggered",
				},
			},
			j_cry_wee_fib = {
				name = "Weebonacci",
				text = {
					"This Joker gains",
					"{C:mult}+#2#{} Mult when each played",
					"{C:attention}Ace{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}8{}",
					"is scored",
					"{C:inactive}(現在 {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_cry_weegaming = {
				name = "2D",
				text = {
					"Retrigger each played {C:attention}2{}", --wee gaming
					"{C:attention}#1#{} additional time#<s>1#", --wee gaming?
					"{C:inactive,s:0.8}Wee Gaming?{}",
				},
			},
			j_cry_wheelhope = {
				name = "Wheel of Hope",
				text = {
					"This Joker gains",
					"倍率 {X:mult,C:white} X#1# {} when failing",
					"a {C:attention}Wheel of Fortune{}",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_whip = {
				name = "The WHIP",
				text = {
					"This Joker gains 倍率 {X:mult,C:white} X#1# {}",
					"if {C:attention}played hand{} contains a",
					"{C:attention}2{} and {C:attention}7{} of different suits",
					"{C:inactive}(現在 倍率 {X:mult,C:white} X#2# {C:inactive})",
				},
			},
			j_cry_wonka_bar = {
				name = "Wonka Bar",
				text = {
					"Sell this card to",
					"permanently gain {C:attention}+#1#{}",
					"card selection limit",
				},
			},
			j_cry_wrapped = {
				name = "Wrapped Candy",
				text = {
					"Create a random {C:attention}Food Joker{}",
					"in {C:attention}#1#{} round#<s>1#",
					"{C:red,E:2}self destructs{}",
				},
			},
			j_cry_wtf = {
				name = Cryptid_config.family_mode and "The Cluster" or "The Fuck!?",
				text = {
					"プレイしたハンドが",
					"{C:attention}#2#{} を含む場合",
					"倍率 {C:red}X#1#{}",
				},
				unlock = {
					"Win a run with",
					"your final hand being",
					"a {E:1,C:attention}#1#",
				},
			},
			j_cry_zooble = {
				name = "Zooble",
				text = {
					"If played hand does",
					"{C:attention}not{} contain a {C:attention}Straight{},",
					"this Joker gains {C:mult}+#2#{} Mult for every",
					"{C:attention}unique rank{} in scoring hand",
					"{C:inactive}(現在 {C:mult}+#1#{C:inactive} Mult)",
				},
			},
		},
		Planet = {
			c_cry_asteroidbelt = {
				name = "小惑星帯",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){} レベルアップ",
					"{C:attention}#2#",
					"倍率 {C:mult}+#3#{}",
					"チップ {C:chips}+#4#{}",
				},
			},
			c_cry_void = {
				name = "虚無〈ヴォイド〉",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){} レベルアップ",
					"{C:attention}#2#",
					"倍率 {C:mult}+#3#{}",
					"チップ {C:chips}+#4#{}",
				},
			},
			c_cry_marsmoons = {
				name = "フォボスとダイモス",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){} レベルアップ",
					"{C:attention}#2#",
					"倍率 {C:mult}+#3#{}",
					"チップ {C:chips}+#4#{}",
				},
			},
			c_cry_nibiru = {
				name = "ニビル",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){} レベルアップ",
					"{C:attention}#2#",
					"倍率 {C:mult}+#3#{}",
					"チップ {C:chips}+#4#{}",
				},
			},
			c_cry_universe = {
				name = "ユニバース",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){} レベルアップ",
					"{C:attention}#2#",
					"倍率 {C:mult}+#3#{}",
					"チップ {C:chips}+#4#{}",
				},
			},
			c_cry_planetlua = {
				name = "Planet.lua",
				text = {
					"{C:green}#2#分の#1#{} の確率で",
					"全ての",
					"{C:legendary,E:1}ポーカーハンド{}の",
					"レベルを {C:attention}1{} 上げる",
				},
			},
			c_cry_nstar = {
				name = "中性子星",
				text = {
					"ランダムな",
					"ポーカーハンド のレベルを",
					"このランで {C:attention}中性子星{} が使用された回数につき",
					"{C:attention}1{} 上げる",
					"{C:inactive}(現在{C:attention} #1#{C:inactive}回){}",
				},
			},
			c_cry_sunplanet = {
				name = "日",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){}",
					"{C:attention}昇天{}ハンドの 昇天係数を",
					"{X:gold,C:white}#2#{} 増やす",
					"{C:inactive}(現在 昇天値 {C:attention}1{C:inactive} につき",
					"{C:chips}チップ{}と{C:mult}倍率 {X:gold,C:white}X#3#{C:inactive})",
				},
			},
			c_cry_sunplanet2 = {
				name = "日",
				text = {
					"{S:0.8}({S:0.8,V:1}レベル#1#{S:0.8}){}",
					"{C:attention}昇天{}ハンドの 昇天係数を",
					"{X:gold,C:white}#2#{} 増やす",
					"{C:inactive}(現在 昇天値 {C:attention}1{C:inactive} につき",
					"{C:chips}チップ{}と{C:mult}倍率 {X:gold,C:white}+#3#{C:inactive})",
				},
			},
			c_cry_Timantii = {
				name = "ルートゥ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
			c_cry_Klubi = {
				name = "リスティ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
			c_cry_Sydan = {
				name = "ヘルッタ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
			c_cry_Lapio = {
				name = "パタ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
			c_cry_Kaikki = {
				name = "カイッキ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
			c_cry_perkele = {
				name = "ペルケレ",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
					"{C:inactive}(現在 昇天値 {C:attention}1{C:inactive} につき",
					"{C:chips}チップ{}と{C:mult}倍率 {X:gold,C:white}X#3#{C:inactive})",
				},
			},
			c_cry_voxel = {
				name = "ヴォクセル",
				text = {
					"({V:1}Lv.#4#{})({V:2}Lv.#5#{})({V:3}Lv.#6#{})",
					"{C:attention}#1#{}と",
					"{C:attention}#2#{}と",
					"{C:attention}#3#{}の",
					"レベルを上げる",
				},
			},
		},
		Sleeve = {
			sleeve_cry_beige_sleeve = {
				name = "Beige Sleeve",
				text = {
					"{C:attention}Common{} Jokers have",
					"{C:attention}quadrupled{} values",
				},
			},
			sleeve_cry_beige_sleeve_alt = {
				name = "Beige Sleeve",
				text = {
					"{C:attention}Uncommon{} Jokers have",
					"{C:attention}quadrupled{} values",
				},
			},
			sleeve_cry_beta_sleeve = {
				name = "Nostalgic Sleeve",
				text = {
					"{C:attention}Joker{} and {C:attention}Consumable{}",
					"slots are {C:attention}combined",
					"{C:attention}Nostalgic{} ブラインド replace",
					"their updated ブラインド",
				},
			},
			sleeve_cry_bountiful_sleeve = {
				name = "Bountiful Sleeve",
				text = {
					"After {C:blue}Play{} or {C:red}Discard{},",
					"always draw {C:attention}5{} cards",
				},
			},
			sleeve_cry_ccd_sleeve = {
				name = "CCD Sleeve",
				text = {
					"Every card is also",
					"a {C:attention}random{} consumable",
				},
			},
			sleeve_cry_conveyor_sleeve = {
				name = "Conveyor Sleeve",
				text = {
					"Jokers may {C:attention}not{} be moved",
					"At start of round,",
					"{C:attention}duplicate{} rightmost Joker",
					"and {C:attention}destroy{} leftmost Joker",
				},
			},
			sleeve_cry_critical_sleeve = {
				name = "Critical Sleeve",
				text = {
					"After each hand played,",
					"{C:green}1 in 4{} chance for {X:dark_edition,C:white} ^2 {} Mult",
					"{C:green}1 in 8{} chance for {X:dark_edition,C:white} ^0.5 {} Mult",
				},
			},
			sleeve_cry_encoded_sleeve = {
				name = "Encoded Sleeve",
				text = {
					"Start with a {C:cry_code,T:j_cry_CodeJoker}Code Joker{}",
					"and a {C:cry_code,T:j_cry_copypaste}Copy/Paste{}",
					"Only {C:cry_code}Code Cards{} appear in shop",
				},
			},
			sleeve_cry_equilibrium_sleeve = {
				name = "Balanced Sleeve",
				text = {
					"All cards have the",
					"{C:attention}same chance{} of",
					"appearing in shops,",
					"start run with",
					"{C:attention,T:v_overstock_plus}+2 Shop Slots",
				},
			},
			sleeve_cry_glowing_sleeve = {
				name = "Glowing Sleeve",
				text = {
					"Multiply the values of",
					"all Jokers by {X:dark_edition,C:white} X1.25 {}",
					"when ボスブラインド is defeated",
					"{X:cry_jolly,C:white,s:0.8} Jolly#1#Open#1#Winner#1#-#1#wawa#1#person", --peak loc_vars right here
				},
			},
			sleeve_cry_infinite_sleeve = {
				name = "Unlimited Sleeve",
				text = {
					"You can select {C:attention}any",
					"number of cards",
					--someone do the hand size thing for me
				},
			},
			sleeve_cry_misprint_sleeve = {
				name = "Misprinted Sleeve",
				text = {
					"Values of cards",
					"are {C:attention}randomized",
				},
			},
			sleeve_cry_redeemed_sleeve = {
				name = "Redeemed Sleeve",
				text = {
					"When a {C:attention}バウチャー{} is purchased,",
					"gain its {C:attention}extra tiers",
				},
			},
			sleeve_cry_spooky_sleeve = {
				name = "Spooky Sleeve",
				text = {
					"Start with an {C:eternal}Eternal{} {C:attention,T:j_cry_chocolate_dice}Chocolate Die",
					"After each {C:attention}アンティ{}, create a",
					"{C:cry_candy}Candy{} or {X:cry_cursed,C:white}Cursed{} Joker",
				},
			},
			sleeve_cry_very_fair_sleeve = {
				name = "Very Fair Sleeve",
				text = {
					"{C:blue}-2{} hands, {C:red}-2{} ディスカード",
					"every round",
					"{C:attention}バウチャー{} no longer",
					"appear in the shop",
				},
			},
			sleeve_cry_wormhole_sleeve = {
				name = "Wormhole Sleeve",
				text = {
					"Start with an {C:cry_exotic}Exotic{C:attention} Joker",
					"Jokers are {C:attention}20X{} more",
					"likely to be {C:dark_edition}ネガティブ",
					"{C:attention}-2{} Joker slots",
				},
			},
			sleeve_cry_legendary_sleeve = {
				name = "Legendary Sleeve",
				text = {
					"Start with an {C:legendary}Legendary{C:legendary} Joker",
					"{C:green}1 in 5{} chance to create another",
					"when ボスブラインド is defeated {C:inactive}(空きが必要){}",
				},
			},
			sleeve_cry_antimatter_sleeve = {
				name = "Antimatter Sleeve",
				text = {
					"applies the {C:attention}effects{}",
					"and {C:attention}special effects{}",
					"of all deck sleeves",
					"{C:red}WIP",
				},
			},
			sleeve_cry_antimatter_sleeve_balanced = {
				name = "Antimatter Sleeve",
				text = {
					"applies the {C:attention}effects{}",
					"and {C:attention}special effects{}",
					"of {C:attention}every{} sleeve won",
					"with {C:gold}Gold Stake{}",
					"{C:red}WIP",
				},
			},
		},
		Spectral = {
			c_cry_adversary = {
				name = "アドバーサリー",
				text = {
					"{C:red}全て{}の所持{C:attention}ジョーカー{}が{C:dark_edition}ネガティブ{}になる",
					"以降ショップの{C:red}全て{}の{C:attention}ジョーカー{}の価格が",
					"{C:red}2倍{}になる",
				},
			},
			c_cry_analog = {
				name = "アナログ",
				text = {
					"ランダムな{C:attention}ジョーカー{}のコピーを",
					"{C:attention}#1#{}枚作り",
					"それ以外のジョーカーを破壊する",
					"アンティ {C:attention}+#2#{}",
				},
			},
			c_cry_chambered = {
				name = "チャンバー",
				text = {
					"所持している{C:attention}ランダムな{}消耗品の",
					"{C:dark_edition}ネガティブ{}コピーを{C:attention}#1#{}枚作る",
					"{C:inactive,s:0.8}但し チャンバー は除く{}",
				},
			},
			c_cry_conduit = {
				name = "コンジット",
				text = {
					"選択された{C:attention}2{}枚のトランプか{C:attention}ジョーカー{}の",
					"{C:attention}エディション{}を入れ替える",
				},
			},
			c_cry_gateway = {
				name = "ゲートウェイ",
				text = {
					"ランダムな{C:cry_exotic,E:1}エキゾチック{C:attention}{C:attention}ジョーカー{}を作成し",
					"それ以外のジョーカーを破壊する",
				},
			},
			c_cry_hammerspace = {
				name = "ハンマースペース",
				text = {
					"Apply random {C:attention}consumables{}",
					"as if they were {C:dark_edition}Enhancements{}",
					"to cards held in hand",
				},
			},
			c_cry_lock = {
				name = "ロック",
				text = {
					"{C:red}全ての{}ジョーカーから",
					"{C:red}全ての{} ステッカーを削除する",
					"ランダムな{C:attention}ジョーカー{}に",
					"{C:purple,E:1}エターナル{}を付与する",
				},
			},
			c_cry_pointer = {
				name = "POINTER://",
				text = {
					"{C:cry_code}好きなカード{}を",
					"1枚だけ作成する",
					"{C:inactive,s:0.8}(エキゾチックジョーカーは除く)",
				},
			},
			c_cry_replica = {
				name = "レプリカ",
				text = {
					"手札にある全てのカードを",
					"いずれかの{C:attention}ランダムな{}手札に変換する"
				},
			},
			c_cry_ritual = {
				name = "Ritual",
				text = {
					"Apply {C:dark_edition}ネガティブ{}, {C:dark_edition}Mosaic{},",
					"or {C:dark_edition}Astral{} to {C:attention}#1#{}",
					"selected card#<s>1# in hand",
				},
			},
			c_cry_source = {
				name = "Source",
				text = {
					"Add a {C:cry_code}Green Seal{}",
					"to {C:attention}#1#{} selected",
					"card#<s>1# in your hand",
				},
			},
			c_cry_summoning = {
				name = "Summoning",
				text = {
					"Create a random",
					"{V:1}#1#{} {C:joker}Joker{}, destroy",
					"one random {C:joker}Joker{}",
				},
			},
			c_cry_trade = {
				name = "Trade",
				text = {
					"{C:attention}Lose{} a random バウチャー,",
					"gain {C:attention}2{} random バウチャー",
				},
			},
			c_cry_typhoon = {
				name = "Typhoon",
				text = {
					"Add an {C:cry_azure}Azure Seal{}",
					"to {C:attention}#1#{} selected",
					"card#<s>1# in your hand",
				},
			},
			c_cry_meld = {
				name = "Meld",
				text = {
					"Select a {C:attention}Joker{} or",
					"{C:attention}トランプ{} to",
					"become {C:dark_edition}両面",
				},
			},
			c_cry_vacuum = {
				name = "Vacuum",
				text = {
					"Removes {C:red}all {C:green}modifications{}",
					"from {C:red}all{} cards held in hand,",
					"Earn {C:money}$#1#{} per {C:green}modification{} removed",
					"{C:inactive,s:0.7}(ex. Enhancements, Seals, Editions)",
				},
			},
			c_cry_white_hole = {
				name = "White Hole",
				text = {
					"Upgrade {C:legendary,E:1}most played{}",
					"ポーカーハンド by {C:attention}4{}",
					"{C:attention}Remove{} all other hand levels",
				},
			},
			c_cry_white_hole2 = {
				name = "White Hole",
				text = {
					"{C:attention}Remove{} all hand levels,",
					"upgrade {C:legendary,E:1}most played{} ポーカーハンド",
					"by {C:attention}3{} for each removed level",
				},
			},
		},
		Stake = {
			stake_cry_pink = {
				name = "Pink Stake",
				colour = "Pink", --this is used for auto-generated sticker localization
				text = {
					"Required score scales",
					"faster for each {C:attention}アンティ",
				},
			},
			stake_cry_brown = {
				name = "Brown Stake",
				colour = "Brown",
				text = {
					"All {C:attention}stickers{} are compatible",
					"with each other",
				},
			},
			stake_cry_yellow = {
				name = "Yellow Stake",
				colour = "Yellow",
				text = {
					"{C:attention}Stickers{} can appear on",
					"all purchasable items",
				},
			},
			stake_cry_jade = {
				name = "Jade Stake",
				colour = "Jade",
				text = {
					"Cards can be drawn {C:attention}face down{}",
				},
			},
			stake_cry_cyan = {
				name = "Cyan Stake",
				colour = "Cyan",
				text = {
					"{C:green}Uncommon{} and {C:red}Rare{} Jokers are",
					"less likely to appear",
				},
			},
			stake_cry_gray = {
				name = "Gray Stake",
				colour = "Gray",
				text = {
					"Rerolls increase by {C:attention}$2{} each",
				},
			},
			stake_cry_crimson = {
				name = "Crimson Stake",
				colour = "Crimson",
				text = {
					"バウチャー restock on {C:attention}even{} アンティs",
				},
			},
			stake_cry_diamond = {
				name = "Diamond Stake",
				colour = "Diamond",
				text = {
					"Must beat アンティ {C:attention}10{} to win",
				},
			},
			stake_cry_amber = {
				name = "Amber Stake",
				colour = "Amber",
				text = {
					"{C:attention}-1{} Booster Pack slot",
				},
			},
			stake_cry_bronze = {
				name = "Bronze Stake",
				colour = "Bronze",
				text = {
					"バウチャー are {C:attention}50%{} more expensive",
				},
			},
			stake_cry_quartz = {
				name = "Quartz Stake",
				colour = "Quartz",
				text = {
					"Jokers can be {C:attention}Pinned{}",
					"{s:0.8,C:inactive}(Stays pinned to the leftmost position){}",
				},
			},
			stake_cry_ruby = {
				name = "Ruby Stake",
				colour = "Ruby",
				text = {
					"{C:attention}Big{} ブラインド can become",
					"{C:attention}Boss{} ブラインド",
				},
			},
			stake_cry_glass = {
				name = "Glass Stake",
				colour = "Glass",
				text = {
					"Cards can {C:attention}shatter{} when scored",
				},
			},
			stake_cry_sapphire = {
				name = "Sapphire Stake",
				colour = "Sapphire",
				text = {
					"Lose {C:attention}25%{} of current money",
					"at end of アンティ",
					"{s:0.8,C:inactive}(Up to $10){}",
				},
			},
			stake_cry_emerald = {
				name = "Emerald Stake",
				colour = "Emerald",
				text = {
					"Cards, packs, and バウチャー",
					"can be {C:attention}face down{}",
					"{s:0.8,C:inactive}(Unable to be viewed until purchased){}",
				},
			},
			stake_cry_platinum = {
				name = "Platinum Stake",
				colour = "Platinum",
				text = {
					"Small ブラインド are {C:attention}removed{}",
				},
			},
			stake_cry_twilight = {
				name = "Twilight Stake",
				colour = "Twilight",
				text = {
					"Cards can be {C:attention}Banana{}",
					"{s:0.8,C:inactive}(1 in 10 chance of being destroyed each round){}",
				},
			},
			stake_cry_verdant = {
				name = "Verdant Stake",
				colour = "Verdant",
				text = {
					"Required score scales",
					"faster for each {C:attention}アンティ",
				},
			},
			stake_cry_ember = {
				name = "Ember Stake",
				colour = "Ember",
				text = {
					"All items give no money when sold",
				},
			},
			stake_cry_dawn = {
				name = "Dawn Stake",
				colour = "Dawn",
				text = {
					"Tarots and Spectrals target {C:attention}1",
					"fewer card",
					"{s:0.8,C:inactive}(Minimum of 1){}",
				},
			},
			stake_cry_horizon = {
				name = "Horizon Stake",
				colour = "Horizon",
				text = {
					"When ブラインド selected, add a",
					"{C:attention}random card{} to deck",
				},
			},
			stake_cry_blossom = {
				name = "Blossom Stake",
				colour = "Blossom",
				text = {
					"{C:attention}Final{} ボスブラインド can appear",
					"in {C:attention}any{} アンティ",
				},
			},
			stake_cry_azure = {
				name = "Azure Stake",
				colour = "Azure",
				text = {
					"Values on Jokers are reduced",
					"by {C:attention}20%{}",
				},
			},
			stake_cry_ascendant = {
				name = "Ascendant Stake",
				colour = "Ascendant",
				text = {
					"{C:attention}-1{} Shop slot",
				},
			},
		},
		Tag = {
			tag_cry_astral = {
				name = "Astral タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Astral{}",
				},
			},
			tag_cry_banana = {
				name = "Banana タグ",
				text = {
					"Creates {C:attention}#1#",
					"{C:inactive}(空きが必要){}",
				},
			},
			tag_cry_bettertop_up = {
				name = "Better Top-up タグ",
				text = {
					"Creates up to {C:attention}#1#",
					"{C:green}Uncommon{} Joker#<s>1#",
					"{C:inactive}(空きが必要){}",
				},
			},
			tag_cry_better_voucher = {
				name = "Golden バウチャー タグ",
				text = {
					"Adds one Tier {C:attention}#1#{} バウチャー",
					"to the next shop",
				},
			},
			tag_cry_blur = {
				name = "Blurred タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Blurred{}",
				},
			},
			tag_cry_booster = {
				name = "Booster タグ",
				text = {
					"Next {C:cry_code}Booster Pack{} has",
					"{C:attention}double{} cards and",
					"{C:attention}double{} choices",
				},
			},
			tag_cry_bundle = {
				name = "Bundle タグ",
				text = {
					"Create a {C:attention}Standard タグ{}, {C:tarot}Charm タグ{},",
					"{C:attention}Buffoon タグ{}, and {C:planet}Meteor タグ",
				},
			},
			tag_cry_cat = {
				name = "Cat タグ",
				text = { "Meow.", "{C:inactive}Level {C:dark_edition}#1#" },
			},
			tag_cry_console = {
				name = "Console タグ",
				text = {
					"Gives a free",
					"{C:cry_code}Program Pack",
				},
			},
			tag_cry_double_m = {
				name = "Double M タグ",
				text = {
					"Shop has a",
					"{C:dark_edition}Jolly {C:legendary}M Joker{}",
				},
			},
			tag_cry_empowered = {
				name = "Empowered タグ",
				text = {
					"Gives a free {C:spectral}Spectral Pack",
					"with {C:legendary,E:1}The Soul{} and {C:cry_exotic,E:1}Gateway{}",
				},
			},
			tag_cry_epic = {
				name = "Epic タグ",
				text = {
					"Shop has a half-price",
					"{C:cry_epic}Epic Joker",
				},
			},
			tag_cry_gambler = {
				name = "Gambler's タグ",
				text = {
					"{C:green}#1# in #2#{} chance to create",
					"an {C:cry_exotic,E:1}Empowered タグ",
				},
			},
			tag_cry_glass = {
				name = "Fragile タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Fragile{}",
				},
			},
			tag_cry_glitched = {
				name = "Glitched タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Glitched{}",
				},
			},
			tag_cry_gold = {
				name = "Golden タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Golden{}",
				},
			},
			tag_cry_gourmand = {
				name = "Gourmand タグ",
				text = {
					"Shop has a free",
					"{C:attention}Food Joker",
				},
			},
			tag_cry_loss = {
				name = "Loss",
				text = {
					"Gives a free",
					"{C:cry_ascendant}Meme Pack",
				},
			},
			tag_cry_m = {
				name = "Jolly タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Jolly{}",
				},
			},
			tag_cry_memory = {
				name = "Memory タグ",
				text = {
					"Create {C:attention}#1#{} cop#<ies,y>1# of",
					"the last {C:attention}タグ{} used",
					"during this run",
					"{s:0.8,C:inactive}Copying タグ excluded",
					"{s:0.8,C:inactive}現在: {s:0.8,C:attention}#2#",
				},
			},
			tag_cry_mosaic = {
				name = "Mosaic タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Mosaic{}",
				},
			},
			tag_cry_oversat = {
				name = "Oversaturated タグ",
				text = {
					"Next base edition shop",
					"Joker is free and",
					"becomes {C:dark_edition}Oversaturated{}",
				},
			},
			tag_cry_quadruple = {
				name = "Quadruple タグ",
				text = {
					"Gives {C:attention}#1#{} cop#<ies,y>1# of the",
					"next selected {C:attention}タグ",
					"{s:0.8,C:inactive}Copying タグ excluded",
				},
			},
			tag_cry_quintuple = {
				name = "Quintuple タグ",
				text = {
					"Gives {C:attention}#1#{} cop#<ies,y>1# of the",
					"next selected {C:attention}タグ",
					"{s:0.8,C:inactive}Copying タグ excluded",
				},
			},
			tag_cry_rework = {
				name = "リワークタグ",
				text = {
					"ショップに #3#",
					"{C:dark_edition}#1# の {C:cry_code}#2# を",
					"追加する",
				},
			},
			tag_cry_schematic = {
				name = "Schematic タグ",
				text = {
					"Shop has a",
					"{C:attention}Brainstorm",
				},
			},
			tag_cry_scope = {
				name = "Scope タグ",
				text = {
					"{C:attention}+#1# {C:blue}hand#<s>1#{} and",
					"{C:red}discard#<s>1#{} next round",
				},
			},
			tag_cry_triple = {
				name = "Triple タグ",
				text = {
					"Gives {C:attention}#1#{} cop#<ies,y>1# of the",
					"next selected {C:attention}タグ",
					"{s:0.8,C:inactive}Copying タグ excluded",
				},
			},
			tag_cry_clone = {
				name = "Clone タグ",
				text = {
					"Shop Items cost {C:attention}X#1#{}",
					"as much, obtain a {C:attention}Copy{}",
					"of the next bought card",
				},
			},
			tag_cry_lens = {
				name = "Lens タグ",
				text = {
					"Apply {C:dark_edition}ネガティブ{}",
					"to {C:attention}#1#{} random",
					"consumable#<s>1#",
				},
			},
			tag_cry_palette_cleanser = {
				name = "Palette Cleanser タグ",
				text = {
					"Remove a {C:attention}random{}",
					"sticker from a {C:attention}random{}",
					"Joker or トランプ",
				},
			},
		},
		Tarot = {
			c_cry_automaton = {
				name = "The Automaton",
				text = {
					"Creates up to {C:attention}#1#",
					"random {C:cry_code}Code{} card#<s>1#",
					"{C:inactive}(Must have room)",
				},
			},
			c_cry_eclipse = {
				name = "The Eclipse",
				text = {
					"Enhances {C:attention}#1#{} selected card#<s>1#",
					"into an {C:attention}Echo Card",
				},
			},
			c_cry_instability = {
				name = "Instability",
				text = {
					"Enhances {C:attention}#1#{} selected card#<s>1#",
					"into an {C:attention}Abstract Card",
				},
			},
			c_cry_theblessing = {
				name = "The Blessing",
				text = {
					"Creates {C:attention}1{}",
					"random {C:attention}consumable{}",
					"{C:inactive}(空きが必要){}",
				},
			},
			c_cry_seraph = {
				name = "The Seraph",
				text = {
					"Enhances {C:attention}#1#{} selected card#<s>1#",
					"into {C:attention}Light Cards",
				},
			},
		},
		Voucher = {
			-- Standard Vouchers
			v_cry_copies = {
				name = "コピー",
				text = {
					"ダブルタグが{C:attention}トリプルタグ{}になり",
					"出現確率 {C:attention}2X{}",
				},
			},
			v_cry_tag_printer = {
				name = "タグ印刷機",
				text = {
					"ダブルタグが{C:attention}クアドラプルタグ{}になり",
					"出現確率 {C:attention}3X{}",
				},
			},
			v_cry_pairing = {
				name = "ペアリング",
				text = {
					"プレイされたハンドが{C:attention}ワンペア{}の場合",
					"すべての M ジョーカー を {C:attention}再発動{}する",
				},
			},
			v_cry_repair_man = {
				name = "修理工",
				text = {
					"プレイされたハンドが{C:attention}ワンペア{}を含む場合",
					"すべての M ジョーカー を {C:attention}再発動{}する",
				},
			},
			v_cry_double_vision = {
				name = "複視",
				text = {
					"{C:dark_edition}両面{}カードの",
					"出現確率 {C:attention}4X{}",
				},
			},
			v_cry_double_slit = {
				name = "Double Slit",
				text = {
					"{C:attention}Meld{} が",
					"いずれかの {C:spectral}スペクトル{}パック に", 
					"含まれている可能性がある",
				},
			},
			v_cry_stickyhand = {
				name = "粘着ハンド",
				text = {
					"カードの選択上限 {C:attention}+#1#{}",
				},
			},
			v_cry_grapplinghook = {
				name = "鈎縄",
				text = {
					"カードの選択上限 {C:attention}+#1#{}",
					"{C:inactive,s:0.7}君が思ってる以上のことができるさ{}",
				},
			},
			v_cry_command_prompt = {
				name = "コマンドプロンプト",
				text = {
					"{C:cry_code}コード{} カードを",
					"{C:attention}ショップ{}で",
					"購入できる",
				},
			},
			v_cry_satellite_uplink = {
				name = "衛星通信",
				text = {
					"{C:cry_code}コード{} カードが",
					"いずれかの {C:spectral}惑星{}パック に", 
					"含まれている可能性がある",
				},
			},

			-- T3 Vouchers
			v_cry_overstock_multi = {
				name = "マルチストック",
				text = {
					"ショップの",
					"カード枠{C:attention}+#1#{}",
					"ブースターパック枠 {C:attention}+#1#{}",
					"バウチャー枠 {C:attention}+#1#{}",
				},
				unlock = {
					"1回のランで",
					"{C:attention}1000${} をショップで使う",
				},
			},
			v_cry_massproduct = {
				name = "大量生産",
				text = {
					"すべてのカードとパックの",
					"ショップ価格を {C:attention}$1{} にする",
				},
				unlock = {
					"1回のランで",
					"{C:attention}バウチャー{}を",
					"{C:attention}25{}回",
					"引き換える",
				},
			},
			v_cry_curate = {
				name = "厳選",
				text = {
					"すべてのカードが",
					"何らかの {C:dark_edition}エディション{}で",
					"出現する",
				},
				unlock = {
					"すべての{C:attention}エディション{}を",
					"発見する",
				},
			},
			v_cry_rerollexchange = {
				name = "リセマラ",
				text = {
					"すべてのリロールコストを",
					"{C:attention}$2{} にする",
				},
				unlock = {
					"1回のランで",
					"ショップの{C:attention}リロール{}を",
					"{C:attention}250回{}行う",
				},
			},
			-- RESERVATION FOR CRYSTAL BALL T3
			-- RESERVATION FOR TELESCOPE T3
			-- v_cry_scope = {
			-- 	name = "Galactic Scope",
			-- 	text = {
			-- 		"Create the {C:planet}Planet",
			-- 		"card for played",
			-- 		"{C:attention}ポーカーハンド{}",
			-- 		"{C:inactive}(空きが必要){}",
			-- 	},
			-- 	unlock = {
			-- 		"Use {C:attention}50{} {C:planet}Planet",
			-- 		"cards from",
			-- 		"{C:attention}Booster Packs{}",
			-- 		"in one run",
			-- 	},
			-- },
			v_cry_dexterity = {
				name = "熟練",
				text = {
					"ラウンド毎に",
					"永久的に",
					"ハンド {C:blue}+#1#{} を得る",
				},
				unlock = {
					"{C:attention}トランプ{} を", 
					"合計 {C:attention}5000{}枚",
					"プレイする"
				},
			},
			v_cry_threers = {
				name = "3R",
				text = {
					"ラウンド毎に",
					"永久的に",
					"ディスカード {C:red}+#1#{} を得る",
				},
				unlock = {
					"{C:attention}トランプ{} を", 
					"合計 {C:attention}5000{}枚",
					"ディスカードする"
				},
			},
			v_cry_tacclimator = {
				name = "タロット順応器",
				text = {
					"{C:tarot}Tarot{} cards appear",
					"{C:attention}X#1#{} more frequently",
					"in the shop",
					"Allows control of the",
					"shop's {C:tarot}Tarot Rate{}",
					"{C:inactive}(Check {C:attention}Run Info{C:inactive})",
				},
				unlock = {
					"Buy {C:attention}100{} {C:tarot}Tarot",
					"cards total in",
					"the shop",
				},
			},
			v_cry_pacclimator = {
				name = "惑星順応器",
				text = {
					"{C:planet}Planet{} cards appear",
					"{C:attention}X#1#{} more frequently",
					"in the shop",
					"Allows control of the",
					"shop's {C:planet}Planet Rate{}",
					"{C:inactive}(Check {C:attention}Run Info{C:inactive})",
				},
				unlock = {
					"Buy {C:attention}100{} {C:planet}Planet",
					"cards total in",
					"the shop",
				},
			},
			v_cry_moneybean = {
				name = "金の豆の木",
				text = {
					"Raise the cap on",
					"interest earned in",
					"each round to {C:money}$#1#{}",
				},
				unlock = {
					"Max out the",
					"{C:attention}interest earnings{}",
					"for the {C:attention}whole run",
				},
			},
			v_cry_fabric = {
				name = "Universal Fabric",
				text = {
					"{C:dark_edition}+#1#{} Joker slot#<s>1#",
				},
				unlock = {
					"Redeem {C:dark_edition}Antimatter",
					"{C:attention}10{} times",
				},
			},
			-- RESERVATION FOR MAGIC TRICK T3
			v_cry_asteroglyph = {
				name = "アステログリフ",
				text = {
					"アンティを {C:attention}#1#{} にする",
				},
				unlock = {
					"アンティ {C:attention}36 に到達する",
				},
			},
			-- RESERVATION FOR DIRECTOR'S CUT T3
			v_cry_blankcanvas = {
				name = "真白きキャンバス",
				text = {
					"ハンドサイズ {C:attention}+#1#{}",
				},
				unlock = {
					"{C:attention}ハンドサイズ{}を",
					"{C:attention}0{}枚まで減らす",
				},
			},
			-- Cryptid Voucher T3
			v_cry_clone_machine = {
				name = "Clone Machine",
				text = {
					"Double タグ become",
					"{C:attention}Quintuple タグ{} and",
					"are {C:attention}4X{} as common",
				},
			},
			v_cry_pairamount_plus = {
				name = "Pairamount Plus",
				text = {
					"{C:attention}Retrigger{} all M Jokers",
					"once for every Pair",
					"{C:attention}contained{} in played hand",
				},
			},
			v_cry_double_down = {
				name = "Double Down",
				text = {
					"After every round,",
					"{X:dark_edition,C:white} X1.5 {} to all values",
					"on the back of",
					"{C:dark_edition}両面{} cards",
				},
			},
			v_cry_hyperspacetether = {
				name = "Hyperspace Tether",
				text = {
					"{C:attention}+#1#{} card selection limit",
					"All selected cards contribute power",
					"to {C:attention}Ascended Hands{}",
				},
			},
			v_cry_quantum_computing = {
				name = "量子コンピューティング",
				text = {
					"今後得る{C:cry_code}コード{}カードの",
					"使用回数 {C:cry_code}+#1#{}回",
				},
			},
		},
		Other = {
			alt_wheel_of_fortune = {
				name = "運命の輪",
				text = {
					"{C:green}#2#分の#1#{} の確率で",
					"ランダムな {C:attention}ジョーカー{} に",
					"{C:dark_edition}フォイル{}、 {C:dark_edition}ホログラム{}",
					"{C:dark_edition}ポリクローム{} エディションのいずれかを加える",
				},
			},
			asc_misc = {
				name = "昇天ハンド",
				text = {
					"昇天値 {C:gold}#1#{}",
					"{C:chips}チップ{}と{C:mult}倍率 {X:gold,C:white}X#2#",
					"{C:inactive}({C:gold}#3#{C:inactive} の {C:gold}#1#{}乗{C:inactive})",
				},
			},
			asc_misc2 = {
				name = "昇天ハンド",
				text = {
					"昇天値 {C:gold}#1#{}",
					"{C:chips}チップ{}と{C:mult}倍率 {X:gold,C:white}X#2#",
					"{C:inactive}({C:gold}#3#{C:inactive} X {C:gold}#1#{}{C:inactive})",
				},
			},
			disabled = {
				name = "無効",
				text = {
					"このラン中には",
					"出現しない"
				},
			},
			disabled_card_dependency = {
				name = "無効",
				text = {
					"{C:attention}#1#{} が必要",
				},
			},
			disabled_mod_dependency = {
				name = "無効",
				text = {
					"必要なMOD:",
					"{C:attention}#1#",
				},
			},
			disabled_mod_conflict = {
				name = "無効",
				text = {
					"互換性のないMOD:",
					"{C:attention}#1#",
				},
			},
			banana = {
				name = "バナナ",
				text = {
					"{C:green}#2#分の#1#{} の確率で",
					"ラウンド終了時に破壊される",
				},
			},
			cry_absolute = {
				name = "アブソリュート",
				text = {
					"売ることも",
					"壊すことも",
					"{C:attention}このステッカーを取り除くことも",
					"できない",
				},
			},
			cry_rigged = {
				name = "リグ",
				text = {
					"すべての{C:cry_code}掲載された{}確率は",
					"{C:cry_code}厳密に保証{}される",
				},
			},
			cry_hooked = {
				name = "フック",
				text = {
					"このジョーカーが{C:cry_code}発動{}した時",
					"{C:cry_code}#1#{}を発動させる",
					"{C:inactive}すべてのカードの効果を発動できるわけではないが{}",
					"{C:inactive}発動の連鎖起点としては作用する{}",
					"ラウンド終了時に取り除かれる",
				},
			},
			cry_hooked_2 = {
				name = "フック",
				text = {
					"このジョーカーが{C:cry_code}発動{}した時",
					"{C:cry_code}#1#{}を発動させる",
					"{C:inactive}すべてのカードの効果を発動できるわけではないが{}",
					"{C:inactive}発動の連鎖起点としては作用する{}",
				},
			},
			cry_global_sticker = {
				name = "グローバル",
				text = {
					"可能な限り",
					"{C:cry_code}他のカードより先に{}",
					"ドローされる",
				},
			},
			cry_flickering = {
				name = "チカチカ",
				text = {
					"{C:attention}#1#{}回発動すると",
					"破壊される",
					"{C:inactive}(残り {C:attention}#2#{C:inactive}回)",
				},
			},
			cry_flickering_desc = { --used by choco dice
				name = "チカチカ",
				text = {
					"{C:attention}#1#{}回発動すると",
					"破壊される",
				},
			},
			cry_function_sticker = {
				name = "Function://",
				text = {
					"使用すると",
					"{C:cry_code}#1#{} を作成する",
				},
			},
			cry_function_sticker_desc = { --for function:// card
				name = "Function://",
				text = {
					"次の {C:cry_code}Function://{} シールを持つ",
					"消耗品を作成する",
					"{C:inactive}現在 #1# #2# #3#{}",
				},
			},
			cry_possessed = {
				name = "憑依",
				text = {
					"可能ならば効果を {C:attention}反転{}させ",
					"或いは{C:attention}無効化{}する",
					"{C:attention}ゴースト{}とともに破壊される",
				},
			},
			--todo? add candy jokers to list
			food_jokers = {
				name = "Food Jokers",
				text = {
					"{s:0.8}Gros Michel, Egg, Ice Cream, Cavendish,",
					"{s:0.8}Turtle Bean, Diet Cola, Popcorn, Ramen,",
					"{s:0.8}Seltzer, Pickle, Chili Pepper, Caramel,",
					"{s:0.8}Nostalgic Candy, Fast Food M, etc.",
				},
			},
			ev_cry_choco0 = {
				name = "発生するイベント",
				text = {
					"{T:ev_cry_choco1}1{} {T:ev_cry_choco2}2{} {T:ev_cry_choco3}3{} {T:ev_cry_choco4}4{} {T:ev_cry_choco5}5{}",
					"{T:ev_cry_choco6}6{} {T:ev_cry_choco7}7{} {T:ev_cry_choco8}8{} {T:ev_cry_choco9}9{} {T:ev_cry_choco10}10{}",
					"{C:inactive}(マウスオーバーで詳細)",
				},
			},
			ev_cry_choco1 = {
				name = "1: 憑依",
				text = {
					"{C:attention}Jokers{} and トランプ have a",
					"{C:green}1 in 3{} chance of gaining {C:attention}チカチカ{}",
					"Create a {C:attention}Ghost",
					"{C:inactive,s:0.7}You've been possessed by a ghost, and your",
					"{C:inactive,s:0.7}consciousness is flickering in and out.",
				},
			},
			ev_cry_choco2 = {
				name = "2: お化け屋敷",
				text = {
					"Prevents skipping {C:attention}ブラインド{}",
					"One {C:attention}reroll{} allowed per shop",
					"{C:attention}バウチャー{} prices are doubled",
					"{C:inactive,s:0.7}Spooky spirits have taken over! Don't touch",
					"{C:inactive,s:0.7}anything and get out as soon as possible!",
				},
			},
			ev_cry_choco3 = {
				name = "3: 魔女の火鍋",
				text = {
					"Create 3 {C:attention}Potions",
					"Use one by the end of the {C:attention}Small ブラインド{},",
					"or {C:attention}all{} maluses will be applied this {C:attention}アンティ",
					"{C:inactive,s:0.7}You have been kidnapped by a witch!",
					"{C:inactive,s:0.7}She offers you three potions, watching you closely.",
					"{C:inactive,s:0.7}Pick one, lest she makes the decision for you.",
				},
			},
			ev_cry_choco4 = {
				name = "4: 月の深淵",
				text = {
					"Played cards have a {C:green}1 in 4{} chance",
					"to turn into a random {C:club}Club{} face card",
					"Divide {C:attention}Mult{} by number of played face cards",
					"{C:inactive,s:0.7}Even a man who's pure at heart",
					"{C:inactive,s:0.7}and says his prayers by night...",
				},
			},
			ev_cry_choco5 = {
				name = "5: 吸血鬼",
				text = {
					"Remove {C:attention}Enhancements{} from all played cards",
					"{C:green}1 in 3{} chance to destroy",
					"{C:heart}Heart{} and {C:diamond}Diamond{} cards",
					"{C:inactive,s:0.7}Be wary in the dead of night, for",
					"{C:inactive,s:0.7,E:1}they in the shadows{C:inactive,s:0.7} seek to quench their thirst...",
				},
			},
			ev_cry_choco6 = {
				name = "6: お一ついかが？",
				text = {
					"At {C:attention}end of round{}, open a",
					"random {C:attention}Booster{} Pack",
					"{C:inactive,s:0.7}As you stroll down the streets, you spot a",
					"{C:inactive,s:0.7}box of various Booster Packs. Might as well grab one!",
				},
			},
			ev_cry_choco7 = {
				name = "7: お祭り気分",
				text = {
					"Create 3 {C:attention}Trick-or-Treat{} and 1 {C:attention}Candy Basket",
					"Shops have a {C:attention}Trick-or-Treat{} each round",
					"{C:cry_candy}Candies{} give {C:money}$3{} when obtained",
					"{C:inactive,s:0.7}The entire neighbourhood is decorated for spooky endeavours,",
					"{C:inactive,s:0.7}come indulge in the festive atmosphere!",
				},
			},
			ev_cry_choco8 = {
				name = "8: アメのあめ",
				text = {
					"When {C:attention}ブラインド{} defeated, obtain 1 {C:cry_candy}Candy{}",
					"per hand remaining; Obtain a {C:attention}Food Joker{}",
					"when a {C:cry_candy}Candy{} is generated",
					"{C:inactive,s:0.7}Candies rain from the sky! Quick,",
					"{C:inactive,s:0.7,E:1}grab as much as you can!",
				},
			},
			ev_cry_choco9 = {
				name = "9: 埋蔵金",
				text = {
					"Gain {C:money}$20",
					"All {C:money}money{} earned is {C:attention}doubled",
					"{C:inactive,s:0.7}The spectre of a long-gone relative of yours",
					"{C:inactive,s:0.7}visits you in the middle of the night!",
					"{C:inactive,s:0.7}Without a word, they place a bag of money in your hands,",
					"{C:inactive,s:0.7}smile warmly, and wave as they fade into the air.",
				},
			},
			ev_cry_choco10 = {
				name = "10: 骨董品",
				text = {
					"A {C:legendary}Legendary{} {C:attention}Joker{} appears",
					"in the {C:attention}バウチャー{} slot for {C:money}$50",
					"Only buyable as {C:attention}last{} item in shop",
					"{C:inactive,s:0.7}You've attracted the attention of a relic's spirit,",
					"{C:inactive,s:0.7}but it won't be easy to quell.",
				},
			},
			cry_https_disabled = {
				name = "M",
				text = {
					"{C:attention,s:0.7}Updating{s:0.7} is disabled by default ({C:attention,s:0.7}HTTPS Module{s:0.7})",
				},
			},
			--i am so sorry for this
			--actually some of this needs to be refactored at some point
			cry_eternal_booster = {
				name = "Eternal",
				text = {
					"All cards in pack",
					"are {C:attention}Eternal{}",
				},
			},
			cry_perishable_booster = {
				name = "生モノ",
				text = {
					"All cards in pack",
					"are {C:attention}生モノ{}",
				},
			},
			cry_rental_booster = {
				name = "Rental",
				text = {
					"All cards in pack",
					"are {C:attention}Rental{}",
				},
			},
			cry_pinned_booster = {
				name = "Pinned",
				text = {
					"All cards in pack",
					"are {C:attention}Pinned{}",
				},
			},
			cry_banana_booster = {
				name = "Banana",
				text = {
					"All cards in pack",
					"are {C:attention}Banana{}",
				},
			},
			cry_eternal_voucher = {
				name = "エターナル",
				text = {
					"交換できない",
				},
			},
			cry_perishable_voucher = {
				name = "生モノ",
				text = {
					"{C:attention}#1#{} ラウンド後に",
					"デバフされる",
					"{C:inactive}(残り {C:attention}#2#{C:inactive}ラウンド)",
				},
			},
			cry_rental_voucher = {
				name = "レンタル",
				text = {
					"ラウンド終了時に",
					"{C:money}$#1#{} 失う",
				},
			},
			cry_pinned_voucher = {
				name = "ピン留め",
				text = {
					"購入するまで",
					"ショップに残り続ける",
				},
			},
			cry_banana_voucher = {
				name = "Banana",
				text = {
					"{C:green}#1# in #2#{} chance of being",
					"unredeemed each round",
				},
			},
			-- TODO fix typo
			cry_perishable_consumeable = {
				name = "生モノ",
				text = {
					"ラウンド終了時に",
					"デバフがかかる",
				},
			},
			cry_rental_consumeable = {
				name = "レンタル",
				text = {
					"ラウンド終了時か",
					"使用時に",
					"{C:money}$#1#{} 失う",
				},
			},
			cry_pinned_consumeable = {
				name = "ピン留め",
				text = {
					"{C:inactive}何もしない",
					"{C:inactive}今のところはね…",
				},
			},
			cry_banana_consumeable = {
				name = "バナナ",
				text = {
					"{C:green}#2#分の#1#{} の確率で",
					"使っても何も起きない",
				},
			},
			o_nstar = {
				name = "Observatory Effect",
				text = {
					"{X:mult,C:white}X#1#{} Mult for each",
					"{C:attention}Neutron Star{} used",
					"in this run",
					"{C:inactive}(現在 {X:mult,C:white}X#2#{C:inactive} Mult)",
				},
			},
			o_planetlua = {
				name = "Observatory Effect",
				text = { "" },
			},
			o_sunplanet = {
				name = "Observatory Effect",
				text = {
					"Held {C:attention}Sol{} and {C:attention}Perkele{} Cards",
					"increase {C:attention}昇天値",
					"{C:inactive}(現在 {X:gold,C:white}+#1#{C:inactive})",
				},
			},
			o_perkele = {
				name = "Observatory Effect",
				text = {
					"{X:dark_edition,C:white}^#2#{} mult if played hand is a",
					"{C:attention}#4#{}",
					"{X:mult,C:white}X#2#{} mult if played hand is a {C:attention}#3#{}",
					"Held {C:attention}Sol{} and {C:attention}Perkele{} Cards",
					"increase {C:attention}昇天値",
					"{C:inactive}(現在 {X:gold,C:white}+#1#{C:inactive})",
				},
			},
			p_cry_code_normal_1 = {
				name = "プログラムパック",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:cry_code} Code{} card#<s>2#",
				},
			},
			p_cry_code_normal_2 = {
				name = "プログラムパック",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:cry_code} Code{} card#<s>2#",
				},
			},
			p_cry_code_jumbo_1 = {
				name = "ジャンボプログラムパック",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:cry_code} Code{} card#<s>2#",
				},
			},
			p_cry_code_mega_1 = {
				name = "メガプログラムパック",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:cry_code} Code{} card#<s>2#",
				},
			},
			p_cry_empowered = {
				name = "Empowered Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:spectral} Spectral{} card#<s>2#",
					"{s:0.8,C:inactive}(Generated by Empowered タグ)",
				},
			},
			p_cry_meme_1 = {
				name = "Meme Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Meme Joker#<s>2#{}",
				},
			},
			p_cry_meme_two = {
				name = "Meme Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Meme Joker#<s>2#{}",
				},
			},
			p_cry_meme_three = {
				name = "Meme Pack",
				text = {
					"Choose {C:attention}#1#{} of",
					"up to {C:attention}#2# Meme Joker#<s>2#{}",
				},
			},
			p_cry_baneful_1 = {
				name = "不吉な道化師パック",
				text = {
					"{C:attention}#2#{}枚までの {X:cry_cursed,C:white}呪い{} ジョーカーから",
					"{C:attention}#1#{}枚を選ぶ",
					"{C:attention}スキップ{}すると",
					"{C:attention}右端{}の 所持ジョーカーを",
					"{C:red}消滅{}させる",
				},
			},
			undiscovered_code = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			undiscovered_unique = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			cry_green_seal = {
				name = "グリーンシール",
				text = {
					"プレイしてスコアされなかった時",
					"{C:cry_code}コード{} カードを作る",
					"{C:inactive}(空きが必要)",
				},
			},
			cry_azure_seal = {
				name = "アジュールシール",
				text = {
					"このカードがプレイされた時",
					"その{C:attention}ポーカーハンド{}の",
					"{C:dark_edition}ネガティブ{} {C:planet}惑星{} カードを",
					"{C:attention}#1#{}枚作成する",
					"このカードを {C:red}破壊する{}",
				},
			},
			blurred_sdm0 = {
				name = "a",
				text = {
					'{C:inactive,s:0.8}"I hate this card" - SDM_0, 2024{}',
				},
			},
			cry_multiuse = {
				name = "m",
				text = {
					"{C:inactive}回数: (残り {C:cry_code}#1#{C:inactive})",
				},
			},
		},
		Unique = {
			c_cry_potion = {
				name = "ポーション",
				text = {
					"使用すると",
					"何らかの {C:attention}悪いこと{} が起こる",
					"{C:inactive,s:0.7}チョコレート・ダイによって付与",
				},
			},
		},
	},
	misc = {
		tutorial = {
			cry_intro_1 = {
				"Hello, I'm {C:attention}Joseph J. Joker{}!",
				"Welcome to {C:cry_exotic,E:1}Cryptid{}!",
			},
			cry_intro_2 = {
				"It looks like you've never",
				"played {C:cry_exotic,E:1}Cryptid{} on this profile before.",
				"Let me show you how things work!",
			},
			cry_intro_3 = {
				"*grows hands*",
			},
			cry_intro_4 = {
				"It's hard to summarize this mod in",
				"a few sentences, but what I will say",
				"is that you're in for a {C:cry_exotic,E:1}wild{} ride!",
				"This isn't the same {C:attention}Joker Poker{} you know...",
			},
			cry_intro_5 = {
				"As you might be able to tell by these",
				"{C:cry_ascendant}gamesets{}, I like the letter {C:attention}M{}.",
				"Select a gameset for me to explain...",
				"{s:0.8}Note: Gameset balancing is a heavy work in progress.",
				"{s:0.8}Expect things to change frequently!",
			},
			cry_modest_1 = {
				"Seeking an experience close to vanilla?",
				"Then the {C:cry_ascendant}Modest{} gameset is for you!",
			},
			cry_modest_2 = {
				"Still, be careful of the gimmicks hiding",
				"throughout Cryptid! You never know",
				"what you'll find on the next round...",
			},
			cry_mainline_1 = {
				"Wanna {E:1,C:attention}break{} the game? Good news, you can",
				"do it without going off the deep end!",
			},
			cry_mainline_2 = {
				"Things are still nuts here, but you'll have",
				"the chance to experience the {C:cry_ascendant}progression{}",
				"system. Just don't get too comfortable...",
			},
			cry_mainline_3 = {
				"Because you'll definitely be stronger, but",
				"I've crafted some {E:1,C:dark_edition}bosses{} that",
				"might make you regret selecting this {C:cry_ascendant}gameset{}...",
			},
			cry_madness_1 = {
				"You lookin' to completely {C:red,E:1}annihilate{} your hard drive?",
				"Oh, how fun! The {C:cry_ascendant}Madness{} gameset says",
				"'Balance? {E:1,C:red}WHAT'S THAT!?{}'",
			},
			cry_madness_2 = {
				"I've spent weeks of sleepless, {C:green}Mountain Dew{}-fueled",
				"nights working to ensure this gameset is",
				"{C:cry_ascendant}PERFECTLY BALANCED{}, just for you!",
			},
			cry_madness_3 = {
				"You'll start with everything unlocked, so you",
				"can unleash the {C:red,E:1}full power{} of Cryptid!",
				"Just be careful not to {C:attention,E:1}crash{} the game,",
				"as that'll probably happen before you lose...",
			},
		},
		poker_hands = {
			["cry_Bulwark"] = "砦",
			["cry_Clusterfuck"] = "星団", -- 面白い訳し方が思いつかなかったのでFamily Modeを無視
			["cry_UltPair"] = "アルティメットペア",
			["cry_WholeDeck"] = "デッキ", -- 面白い訳し方が思いつかなかったのでFamily Modeを無視
			["cry-Cluster Bulwark"] = "砦星団",
			["cry_None"] = "無",
		},
		poker_hand_descriptions = {
			["cry_Bulwark"] = {
				"5枚のランクもスートもないハンド",
			},
			["cry_Clusterfuck"] = {
				"最低8枚のワンペア・フラッシュ・ストレートの",
				"いずれも含まないハンド",
			},
			["cry_UltPair"] = {
				"単一のスートで構成されたツーペア2つで構成され",
				"全体で2種類のスートを持つハンド",
			},
			["cry_WholeDeck"] = {
				"トランプのデッキ52枚すべてのカードを",
				"一つ残らずすべて含むハンド",
				"正気か？",
			},
			["cry_None"] = { "カードを1枚も含まないハンド" },

			["cry_Declare0"] = { "ストレートとして計上される" },
			["cry_Declare1"] = { "フラッシュとして計上される" },
			["cry_Declare2"] = { "フルハウスとして計上される" },

			["cry_Declare0_suitless"] = { "ストレートとして計上される", "スートは考慮されない" },
			["cry_Declare1_suitless"] = { "フラッシュとして計上される", "スートは考慮されない" },
			["cry_Declare2_suitless"] = { "フルハウスとして計上される", "スートは考慮されない" },
		},
		achievement_names = {
			ach_cry_ace_in_crash = "Pocket ACE",
			ach_cry_blurred_blurred_joker = "法的失明",
			ach_cry_bullet_hell = "弾幕",
			ach_cry_break_infinity = "無限大の破壊",
			ach_cry_cryptid_the_cryptid = "クリプティッド・ザ・クリプティッド",
			ach_cry_exodia = "エグゾティア",
			ach_cry_freak_house = "フリークハウス",
			ach_cry_googol_play_pass = "Googol Play Pass",
			ach_cry_haxxor = "スーパーハカー",
			ach_cry_home_realtor = "不動産仲介人",
			ach_cry_jokes_on_you = "Joke's on You, Pal!",
			ach_cry_niw_uoy = "!niW uoY",
			ach_cry_now_the_fun_begins = "面白くなってきたぞ",
			ach_cry_patience_virtue = "石の上にも三年",
			ach_cry_perfectly_balanced = "完全均衡",
			ach_cry_pull_request = "Pull Request",
			ach_cry_traffic_jam = "交通渋滞",
			ach_cry_ult_full_skip = "究極の完全スキップ",
			ach_cry_used_crash = "やめてっていったよね",
			ach_cry_what_have_you_done = "何しでかした?!",
			ach_cry_pin = "晒し者",
			ach_cry_technically_positive = "厳密にはポジティブ",
			ach_cry_youre_fucking_kidding = Cryptid_config.family_mode and "You Can't Be Serious"
				or "You're Fucking Kidding",
			ach_cry_stoned = "Stoned",
			ach_cry_fucked = Cryptid_config.family_mode and "Clustered" or "Fucked",
			ach_cry_despaired = "Despaired",
			ach_cry_decked = "Decked",
		},
		achievement_descriptions = {
			ach_cry_ace_in_crash = 'check_for_unlock({type = "ace_in_crash"})',
			ach_cry_blurred_blurred_joker = "ブラー の ブラージョーカーを得る",
			ach_cry_bullet_hell = "15枚の APジョーカー を持つ",
			ach_cry_break_infinity = "1つのハンドで チップ 1.79e308 を超える",
			ach_cry_cryptid_the_cryptid = "クリプティッドを使う",
			ach_cry_exodia = "5枚の エキゾチックジョーカー を持つ",
			ach_cry_freak_house = "Nice を所持した状態でハートの6と9で構成されるフラッシュハウスをプレイする",
			ach_cry_googol_play_pass = "Googol Play Card にリグを付与する",
			ach_cry_haxxor = "チートコードを使う",
			ach_cry_home_realtor = "Activate Happy House before アンティ 8 (without DoE/Antimatter)",
			ach_cry_jokes_on_you = "Trigger The Joke's effect on アンティ 1 and win the run",
			ach_cry_niw_uoy = "アンティ -8 に到達する",
			ach_cry_now_the_fun_begins = "キャンバス を得る",
			ach_cry_patience_virtue = "ラベンダー・ループにて 初回のハンドをプレイするまでに2分以上かけて 勝利する",
			ach_cry_perfectly_balanced = "Beat Very Fair Deck on Ascendant Stake",
			ach_cry_pull_request = "Have ://COMMIT spawn the same Joker that it destroyed",
			ach_cry_traffic_jam = "すべてのラッシュアワーチャレンジをクリアする",
			ach_cry_ult_full_skip = "1ラウンドで勝利する",
			ach_cry_used_crash = "://CRASH を使用する",
			ach_cry_what_have_you_done = "エキゾチックジョーカーを破壊または生贄にする",
			ach_cry_pin = "ピンに負ける",
			ach_cry_technically_positive = "ネガティブ の ネガティブジョーカー を得る",
			ach_cry_youre_fucking_kidding = localize("cry_WholeDeck", "poker_hands") .. "をディスカードする",
			ach_cry_stoned = localize("cry_Bulwark", "poker_hands") .. " を レベル420 にする",
			ach_cry_fucked = localize("cry_Clusterfuck", "poker_hands") .. " を レベル69 にする",
			ach_cry_stoned = localize("cry_UltPair", "poker_hands") .. " を レベル2222 にする",
			ach_cry_stoned = localize("cry_WholeDeck", "poker_hands") .. " を レベル5252 にする",
		},
		challenge_names = {
			c_cry_ballin = "Ballin'",
			c_cry_boss_rush = "Enter the Gungeon",
			c_cry_dagger_war = "Dagger War",
			c_cry_joker_poker = "Joker Poker",
			c_cry_onlycard = "Solo Card",
			c_cry_rng = "RNG",
			c_cry_rush_hour = "Rush Hour I",
			c_cry_rush_hour_ii = "Rush Hour II",
			c_cry_rush_hour_iii = "Rush Hour III",
			c_cry_sticker_sheet = "Sticker Sheet",
			c_cry_sticker_sheet_plus = "Sticker Sheet+",
		},
		dictionary = {
			--Settings Menu
			cry_set_features = "機能",
			cry_set_music = "BGM",
			cry_set_enable_features = "Use this section to enable or disable entire Thematic Sets.",
			cry_feat_achievements = "アチーブメント",
			["cry_feat_antimatter deck"] = "Antimatter Deck",
			cry_feat_blinds = "ブラインド",
			cry_feat_challenges = "チャレンジ",
			["cry_feat_code cards"] = "コードカード",
			["cry_feat_misc. decks"] = "その他のデッキ",
			["cry_feat_https module"] = "HTTPSモジュール",
			["cry_feat_timer mechanics"] = "Timer Mechanics",
			["cry_feat_enhanced decks"] = "強化されたデッキ",
			["cry_feat_epic jokers"] = "エピックジョーカー",
			["cry_feat_exotic jokers"] = "エキゾチックジョーカー",
			["cry_feat_m jokers"] = "M ジョーカー",
			cry_feat_menu = "カスタムメインメニュー",
			["cry_feat_misc."] = "その他",
			["cry_feat_misc. jokers"] = "その他のジョーカー",
			cry_feat_planets = "惑星",
			cry_feat_jokerdisplay = "JokerDisplay (Does Nothing)",
			cry_feat_tags = "タグ",
			cry_feat_sleeves = "スリーブ",
			cry_feat_spectrals = "スペクトル",
			cry_feat_spooky = "Spooky Update",
			["cry_feat_more stakes"] = "ステーク",
			cry_feat_vouchers = "バウチャー",
			cry_mus_jimball = "Jimball (Funkytown by Lipps Inc. - Copyrighted)",
			cry_mus_code = "Code Cards (://LETS_BREAK_THE_GAME by HexaCryonic)",
			cry_mus_exotic = "Exotic Jokers (Joker in Latin by AlexZGreat)",
			cry_mus_high_score = "High Score (Final Boss [For Your Computer] by AlexZGreat)",
			cry_mus_alt_bg = "Background Music (by MathIsFun_)",
			cry_force_tooltips = "Force Tooltips",
			cry_family = "Family Friendly Mode",
			cry_experimental = "Experimental Mode",

			k_cry_program_pack = "プログラムパック",
			k_cry_meme_pack = "ミームパック",
			k_cry_baneful_pack = "不吉な道化師パック",
			cry_baneful_warning = "スキップすると右端のジョーカーを消滅させる",

			cry_critical_hit_ex = "Critical Hit!",
			cry_critical_miss_ex = "Critical Miss!",

			cry_potion1 = "すべてのポーカーハンドのレベルを -1 する",
			cry_potion2 = "ブラインドサイズを X1.15 する",
			cry_potion3 = "ハンドとディスカードを -1 する",

			cry_debuff_oldhouse = "フルハウスが無効になる",
			cry_debuff_oldarm = "4枚以下のカードをプレイしなければならない",
			cry_debuff_oldpillar = "ストレートが無効になる",
			cry_debuff_oldflint = "フラッシュが無効になる",
			cry_debuff_oldmark = "ワンペアを含むポーカーハンドが無効になる",
			cry_debuff_obsidian_orb = "これまでに倒したすべてのボスブラインドの効果が発動する",
			cry_blind_baneful_pack = "ラウンド終了時に不吉な道化師パックを得る",

			cry_tax_placeholder = "(ブラインドの要求スコア X0.4)",
			cry_joke_placeholder = "(8の倍数)",

			k_code = "コード",
			k_chips = "チップ",
			k_content_set = "Thematic Set",
			b_content_sets = "Thematic Sets",
			--Why aren't these in vanilla?
			b_tag = "タグ",
			b_blind = "ブラインド",
			rush_hour_reminder = "Enable the Clock and Lavender loop to play Rush Hour",

			b_tarot_rate = "Tarot Rate",
			b_planet_rate = "Planet Rate",

			k_unique = "Unique",
			b_code_cards = "コードカード",
			b_unique_cards = "Unique Cards",
			b_pull = "PULL",
			b_playing_cards = "トランプ",
			cry_hooked_ex = "フック!",
			k_end_blind = "ブラインドを終了",
			k_cry_shiny = "シャイニー",

			cry_code_rank = "ENTER RANK",
			cry_code_enh = "ENTER ENHANCEMENT",
			cry_code_hand = "ENTER POKER HAND",
			cry_code_enter_card = "ENTER A CARD",
			cry_code_apply = "APPLY",
			cry_code_apply_previous = "APPLY PREVIOUS",
			cry_code_exploit = "EXPLOIT",
			cry_code_exploit_previous = "EXPLOIT PREVIOUS",
			cry_code_create = "CREATE",
			cry_code_create_previous = "CREATE PREVIOUS",
			cry_code_execute = "実行",
			cry_code_cancel = "キャンセル",
			cry_code_enter_hand = "約名を入力",
			cry_code_with_suits = "スートを考慮",
			cry_code_without_suits = "スートを無視",
			cry_code_suitless = "特定のスートを要求しないハンド",
			cry_code_empty = "[独自に定義した役]",
			cry_code_exit = "EXIT",
			cry_code_antevoucher = "次のボスブラインド と バウチャー",
			cry_code_nextjokers = "次のショップジョーカー",
			cry_code_nextcards = "次にドローされるカード",

			b_flip = "裏返す",
			b_merge = "取り込む",
			b_store = "保持",

			cry_hand_bulwark = "砦",
			cry_hand_clusterfuck = "星団",
			cry_hand_ultpair = "アルティメットペア",

			cry_asc_hands = "昇天ハンド",
			cry_p_star = "恒星",

			cry_again_q = "Again?",
			cry_balanced_q = "Balanced...?",
			cry_curse = "Curse",
			cry_curse_ex = "Curse!",
			cry_demicolon = "Demitrigger!",
			cry_sobbing = "Help me...",
			cry_gaming = "Gaming",
			cry_gaming_ex = "Gaming!",
			cry_good_luck_ex = "Good luck!",
			cry_sus_ex = "Impostor!",
			cry_jolly_ex = "Jolly Up!",
			cry_highfive_ex = "High Five!",
			cry_m_minus = "m",
			cry_m = "M",
			cry_m_ex = "M!",
			cry_minus_round = "-1 Round",
			cry_plus_cryptid = "+1 Cryptid",
			cry_plus_card = "+1 Card",
			cry_plus_code = "+1 Code",
			cry_no_triggers = "No triggers left!",
			cry_unredeemed = "Unredeemed...",
			cry_active = "Active",
			cry_inactive = "Inactive",
			cry_divorced = "Divorced!",
			cry_destroyed_ex = "Destroyed!",

			k_disable_music = "Disable Music",

			k_cry_epic = "エピック",
			k_cry_exotic = "エキゾチック",
			k_cry_candy = "キャンディ",
			k_cry_cursed = "呪い",

			k_downgraded_ex = "Downgraded!",

			k_planet_disc = "Circumstellar Disc",
			k_planet_satellite = "Natural Satellites",
			k_planet_universe = Cryptid_config.family_mode and "Universe" or "The Actual Fucking Universe",
			k_planet_nibiru = "Nothing",

			cry_notif_jimball_1 = "Jimball についての",
			cry_notif_jimball_2 = "著作権上の注意",
			cry_notif_jimball_d1 = 'Jimballは 楽曲『Funkytown』を再生します。',
			cry_notif_jimball_d2 = "これは著作権で保護されており、",
			cry_notif_jimball_d3 = "動画配信などに用いることができません。",

			cry_gameset_explanation = {
				"Select a gameset config option",
				"to apply to this card.",
			},
			cry_gameset_disabled = "Disabled",
			cry_gameset_modest = "Modest",
			cry_gameset_mainline = "Mainline",
			cry_gameset_madness = "Madness",
			cry_gameset_custom = "Modified",
			cry_gameset_Custom = "Custom",
			cry_gameset_exp = "Experimental",
			cry_gameset_exp_modest = "Experimental (Modest)",
			cry_gameset_exp_mainline = "Experimental (Mainline)",
			cry_gameset_exp_madness = "Experimental (Madness)",

			cry_view_set_contents = "View Items in Set",

			cry_sapling_an = "an",
			cry_sapling_a = "a",

			b_reset_gameset_modest = "Reset Gameset Config (Modest)",
			b_reset_gameset_mainline = "Reset Gameset Config (Mainline)",
			b_reset_gameset_madness = "Reset Gameset Config (Madness)",

			cry_circus_generic = "{V:#1#}#2#{} Jokers each give {X:mult,C:white} X#3# {} Mult",
		},
		labels = {
			food_jokers = "フードジョーカー",
			banana = "バナナ",
			pinned = "ピン留め",
			cry_absolute = "アブソリュート",
			code = "コード",
			unique = "ユニーク",
			cry_rigged = "リグ",
			cry_hooked = "フック",
			cry_global_sticker = "グローバル",
			cry_flickering = "チカチカ",
			cry_possessed = "憑依",

			cry_green_seal = "グリーンシール",
			cry_azure_seal = "アジュールシール",

			cry_astral = "アストラル",
			cry_blur = "ブラー",
			cry_double_sided = "両面",
			cry_glass = "脆弱",
			cry_glitched = "グリッチ",
			cry_gold = "ゴールデン",
			cry_m = "ジョリー",
			cry_mosaic = "モザイク",
			cry_noisy = "雑音",
			cry_oversat = "過飽和",

			k_cry_epic = "エピック",
			k_cry_exotic = "エキゾチック",
			k_cry_candy = "キャンディ",
			k_cry_cursed = "呪い",
		},
		rnj_loc_txts = {
			stats = {
				plus_mult = { "倍率 {C:red}+#2#{}" },
				plus_chips = { "チップ {C:blue}+#2#{}" },
				x_mult = { "倍率 {X:red,C:white} X#2#{}" },
				x_chips = { "チップ {X:blue,C:white} X#2#{}" },
				h_size = { "ハンドサイズ {C:attention}+#2#{}" },
				money = { "報酬 {C:money}+$#2#{}" },
			},
			stats_inactive = {
				plus_mult = { "{C:inactive}(現在 倍率 {C:red}+#1#{C:inactive})" },
				plus_chips = { "{C:inactive}(現在 チップ {C:blue}+#1#{C:inactive})" },
				x_mult = { "{C:inactive}(現在 倍率 {X:red,C:white} X#1# {C:inactive})" },
				x_chips = { "{C:inactive}(現在 チップ {X:blue,C:white} X#1# {C:inactive})" },
				h_size = { "{C:inactive}(現在 ハンドサイズ {C:attention}+#1#{C:inactive}" },
				money = { "{C:inactive}(現在 {C:money}+$#1#{C:inactive})" },
			},
			actions = {
				make_joker = { "{C:attention}#2#枚のジョーカー{}を作成する" },
				make_tarot = { "{C:attention}#2#枚{}の{C:tarot}タロット{}を作成する" },
				make_planet = { "{C:attention}#2#枚{}の{C:planet}惑星{}カードを作成する" },
				make_spectral = { "{C:attention}#2#枚{}の{C:spectral}スペクトル{}カードを作成する" },
				add_dollars = { "{C:money}$#2#{}を得る" },
			},
			contexts = {
				open_booster = { "when a {C:attention}Booster{} is opened" },
				buying_card = { "when a card is bought" },
				selling_self = { "when this card is sold" },
				selling_card = { "when a card is sold" },
				reroll_shop = { "on reroll" },
				ending_shop = { "at the end of the {C:attention}shop{}" },
				skip_blind = { "when a {C:attention}ブラインド{} is skipped" },
				skipping_booster = { "when any {C:attention}ブースターパック{} is skipped" },
				playing_card_added = { "every time a {C:attention}トランプ{} is added to your deck" },
				first_hand_drawn = { "when round begins" },
				setting_blind = { "when {C:attention}ブラインド{} is selected" },
				remove_playing_cards = { "when a card is destroyed" },
				using_consumeable = { "when a {C:attention}consumable{} card is used" },
				debuffed_hand = { "if played {C:attention}hand{} is not allowed" },
				pre_discard = { "before each ディスカード" },
				discard = { "for each ディスカードed card" },
				end_of_round = { "at end of {C:attention}round{}" },
				individual_play = { "for each card scored" },
				individual_hand_score = { "for each card held in hand during scoring" },
				individual_hand_end = { "for each card held in hand at end of {C:attention}round{}" },
				repetition_play = { "Retrigger played cards" },
				repetition_hand = { "Retrigger held in hand cards" },
				other_joker = { "per {C:attention}Joker{}" },
				before = { "before each {C:attention}hand{}" },
				after = { "after each {C:attention}hand{}" },
				joker_main = {},
			},
			conds = {
				buy_common = { "if it is a {C:blue}Common{} {C:attention}Joker{}" },
				buy_uncommon = { "if it is a {C:green}Uncommon{} {C:attention}Joker{}" },
				tarot = { "if card is a {C:tarot}Tarot{} card" },
				planet = { "if card is a {C:planet}Planet{} card" },
				spectral = { "if card is a {C:spectral}Spectral{} card" },
				joker = { "if card is a {C:attention}Joker{}" },
				suit = { "if card is a {V:1}#3#{}" },
				rank = { "if card is rank {C:attention}#3#{}" },
				face = { "if card is a {C:attention}face{} card" },
				boss = { "if {C:attention}ブラインド{} is a {C:attention}ボス{C:attention}ブラインド{}" },
				non_boss = { "if {C:attention}ブラインド{} is a {C:attention}ボスではない{C:attention}ブラインド{}" },
				small = { "if {C:attention}ブラインド{} is a {C:attention}スモール{C:attention}ブラインド{}" },
				big = { "if {C:attention}ブラインド{} is a {C:attention}ビッグ{C:attention}ブラインド{}" },
				first = { "if it's the {C:attention}first {C:attention}hand{}" },
				last = { "if it's the {C:attention}last {C:attention}hand{}" },
				common = { "if it is a {C:blue}Common{} {C:attention}Joker{}" },
				uncommon = { "if it is an {C:green}Uncommon{} {C:attention}Joker{}" },
				rare = { "if it is a {C:red}Rare{} {C:attention}Joker{}" },
				poker_hand = { "if hand is a {C:attention}#3#{}" },
				or_more = { "if hand contains {C:attention}#3#{} or more cards" },
				or_less = { "if hand contains {C:attention}#3#{} or less cards" },
				hands_left = { "if #3# {C:blue}hand(s){} remaining at end of round" },
				discards_left = { "if #3# {C:red}ディスカード(s){} remaining at end of round" },
				first_discard = { "if it's the {C:attention}first {C:attention}ディスカード{}" },
				last_discard = { "if it's the {C:attention}last {C:attention}ディスカード{}" },
				odds = { "with a {C:green}#4# {C:green}in {C:green}#3#{} chance" },
			},
		},
		v_dictionary = {
			a_xchips = { "チップ X#1#" },
			a_powmult = { "倍率 #1#乗" },
			a_powchips = { "チップ #1#乗" },
			a_powmultchips = { "倍率とチップ #1#乗" },
			a_round = { "ラウンド +#1#" },
			a_candy = { "キャンディ +#1#" },
			a_xchips_minus = { "チップ -X#1#" },
			a_powmult_minus = { "倍率 -#1#乗" },
			a_powchips_minus = { "チップ -^#1#乗" },
			a_powmultchips_minus = { "倍率とチップ -#1#乗" },
			a_round_minus = { "ラウンド -#1#" },
			a_tag_minus = { "タグ -#1#" },
			a_tags_minus = { "タグ -#1#" },
			a_tag = { "タグ +#1#" },
			a_tags = { "タグ +#1#" },

			cry_sticker_name = { "#1# Sticker" },
			cry_sticker_desc = {
				"Used this Joker",
				"to win on #2##1#",
				"#2#Stake#3# difficulty",
			},
			tax_hand = { "Max #1#% of required chips" },
			cry_art = { "美術: #1#" },
			cry_code = { "実装: #1#" },
			cry_idea = { "考案: #1#" },
		},
		v_text = {
			ch_c_cry_all_perishable = { "All Jokers are {C:eternal}生モノ{}" },
			ch_c_cry_all_rental = { "All Jokers are {C:eternal}Rental{}" },
			ch_c_cry_all_pinned = { "All Jokers are {C:eternal}Pinned{}" },
			ch_c_cry_all_banana = { "All Jokers are {C:eternal}Banana{}" },
			ch_c_all_rnj = { "All Jokers are {C:attention}RNJoker{}" },
			ch_c_cry_sticker_sheet_plus = { "All purchasable items have all stickers" },
			ch_c_cry_rush_hour = { "All ボスブラインド are {C:attention}The Clock{} or {C:attention}Lavender Loop" },
			ch_c_cry_rush_hour_ii = { "All ブラインド are {C:attention}ボスブラインド{}" },
			ch_c_cry_rush_hour_iii = {
				"{C:attention}The Clock{} and {C:attention}Lavender Loop{} scale {C:attention}twice{} as fast",
			},
			ch_c_cry_no_tags = { "Skipping is {C:attention}disabled{}" },
			ch_c_cry_no_vouchers = { "{C:attention}バウチャー{} no longer appear in the shop" },
			ch_c_cry_no_boosters = { "{C:attention}Booster Packs{} no longer appear in the shop" },
			ch_c_cry_no_rerolls = { "Rerolling is {C:attention}disabled{}" },
			ch_c_cry_no_consumables = { "{C:attention}Consumables{} no longer appear" },
		},
		-- Thanks to many members of the community for contributing to all of these quips!
		-- There's too many to credit so just go here: https://discord.com/channels/1116389027176787968/1209506360987877408/1237971471146553406
		-- And here: https://discord.com/channels/1116389027176787968/1219749193204371456/1240468252325318667
		very_fair_quips = {
			{ "L", "NO VOUCHERS", "FOR YOU" },
			{ "BOZO", "DID YOU THINK I WOULD", "GIVE YOU A VOUCHER?" },
			{ "NOPE!", "NO VOUCHERS HERE!", "(SLUMPAGE EDITION)" },
			{ "SKILL ISSUE", "IMAGINE BEING GOOD ENOUGH", "FOR A VOUCHER" },
			{ "JIMBO", "FROM MANAGEMENT", "FORGOT TO RESTOCK" },
			{ "OOPS!", "NO VOUCHERS", "" },
			{ "YOU JOKER,", "WHY ARE YOU LOOKING", "OVER HERE? LOL" },
			{ "THE VOUCHER", "IS IN", "ANOTHER CASTLE" },
			{ "$0", "BLANK VOUCHER", "(GET IT?)" },
			{ "ERROR", "CANNOT DO ARITHMETIC ON A NIL VALUE", "(tier4vouchers.lua)" },
			{ "100% OFF", "ON ALL VOUCHERS", "(SOMEONE ALREADY BOUGHT THEM)" },
			{ "TRY AGAIN LATER", "HINT: YOU WON'T HAVE", "ENOUGH MONEY ANYWAYS" },
			{ "HUH?", '"VOUCHER"?', "THAT'S NOT EVEN A WORD..." },
			{ 'HOLD "R"', "TO RESTOCK", "ALL VOUCHERS" },
			{ "DID YOU KNOW?", "PRESSING ALT+F4", "GIVES FREE VOUCHERS!" },
			{ "SORRY,", "THERE ARE NO VOUCHERS", "DUE TO BUDGET CUTS" },
			{ "CALL 1-600-JIMBO", "TO RATE YOUR", "VOUCHER EXPERIENCE" },
			{ "DEFEAT", "ANTE 39 BOSS BLIND", "TO RESTOCK" },
			{ "MAGIC TRICK", "I MADE THIS VOUCHER", "DISAPPEAR" },
			{ "WHY IS A", "VOUCHER LIKE", "A WRITING DESK?" },
			{ "WE HAVE RETRACTED", "YOUR VOUCHERS, THEY WOULD BE", "BETTER USED IN OTHER RUNS" },
			{ "WHY DO THEY CALL IT VOUCHER", "WHEN MULT OUT THE HOT", "IN COLD EAT EAT THE CHIP" },
			{ "SORRY", "THE VOUCHERS ARE EXPERIENCING", "VOUCHIFIA ABORTUS" },
			{ "UNFORTUNATELY", "THE VOUCHRX REWRITE UPDATE", "HAS BEEN CANCELLED" },
			{ "DEFEAT", "BOSS BLIND", "TO CHANGE NOTHING" },
			{ "BIRDS ARE SINGING", "FLOWERS ARE BLOOMING", "KIDS LIKE YOU..." },
			{ "WE ARE SORRY TO SAY", "ALL VOUCHERS HAVE BEEN RECALLED", "DUE TO SALMONELLA EXPOSURE" },
			{ "VOUCHERS COULDN'T ARRIVE", "DUE TO SHOP LAYOUT BEING", "200% OVERBUDGET" },
			{ "YOU LIKE", "BUYING VOUCHERS, DON'T YOU", "YOU'RE A VOUCHERBUYER" },
			{ "VOUCHERS", "!E", "VOUCHER POOL" },
			{ "THERE", "IS NO", "VOUCHER" },
			{ "THERE IS", "NO SANTA", "AND THERE ARE NO VOUCHERS" },
			{ "", "VOUCHERN'T", "" },
			{ "YOU", "JUST LOST", "THE GAME" },
			{ "CAN I OFFER YOU", "A NICE EGG", "IN THESE TRYING TIMES?" },
			{ "GO TOUCH GRASS", "INSTEAD OF USING", "THIS DECK" },
			{ "YOU COULD BE", "PLAYING ON BLUE DECK", "RIGHT NOW" },
			{ "FREE EXOTICS", "GET THEM BEFORE ITS", "TOO LATE (sold out)" },
			{ "PROVE THEM WRONG", "BUY BUYING AN INVISIBLE", "VOUCHER FOR $10" },
			{ "", "no vouchers?", "" },
			{
				"see this ad?",
				"if you are, then it's working",
				"and you could have it for your own",
			},
			{ "YOU'RE MISSING OUT ON", "AT LEAST 5 VOUCHERS RIGHT NOW", "tonktonktonktonktonk" },
			{ "10", "20 NO VOUCHER XD", "30 GOTO 10" },
			{ "VOUCHERS", "ARE A PREMIUM FEATURE", "$199.99 JOLLARS TO UNLOCK" },
			{ "TRUE VOUCHERLESS!?!?", "ASCENDANT STAKE ONLY", "VERY FAIR DECK" },
			{ "ENJOYING YOUR", "VOUCHER EXPERIENCE? GIVE US A", "FIVE STAR RATING ON JESTELP" },
			{
				"FREE VOUCHERS",
				"HOT VOUCHERS NEAR YOU",
				"GET VOUCHERS QUICK WITH THIS ONE TRICK",
			},
			{ "INTRODUCING", "THE VERY FIRST TIER 0 VOUCHER!", "(coming to Cryptid 1.0 soon)" },
			{
				"A VOUCHER!",
				"IT'S JUST IMAGINARY",
				"WE IMAGINED YOU WOULD WANT IT, THAT IS",
			},
			{ "TURN OFF ADBLOCKER", "WITHOUT ADS, WE WOULDN'T", "BE ABLE TO SELL YOU VOUCHERS" },
			{
				"IF YOU HAVE",
				"A PROBLEM WITH THIS",
				"EMAIL IT TO US AT NORESPONSE@JMAIL.COM",
			},
			{ "NOT ENOUGH MONEY", "TO BUY THIS VOUCHER", "SO WHY WOULD WE PUT IT HERE?" },
			{ "WANT A VOUCHER?", "WELL SHUT UP", "YOU CAN'T HAVE ANY LOL" },
			{ "^$%& NO", "VOUCHERS ^%&% %&$^% FOR", "$%&%%$ %&$&*%$^ YOU" },
			{ "A VOUCHER (TRUST)", "|\\/|", "|/\\|" },
			{
				"... --- ...",
				".--. .-.. .- -.-- . .-. -.. . -.-. --- -.. . -.. -- --- .-. ... .",
				"-.-. --- -.. . - --- ..-. .. -. -.. .- ...- --- ..- -.-. .... . .-.",
			},
			{ "RUN > NEW", "STARE AT NOTHING", "FOR AN HOUR OR TWO" },
			{ "WE'RE VERY SORRY", "THE LAST GUY PANIC BOUGHT", "ALL THE VOUCHERS" },
			{ "HOW IT FEELS", "TO BUY NO", "VOUCHERS" },
			{ "JIMBO GOT A NAT 1", "AND DUMPED ALL THE", "VOUCHERS IN A DITCH" },
			{ "ATTEMPT TO INDEX", "FIELD 'VOUCHER'", "(A NIL VALUE)" },
			{
				"OH YOU REALLY THOUGHT THAT READING ALL THESE LINES WOULD BRING YOUR VOUCHERS BACK?",
				"SORRY TO TELL YOU, BUT THIS DECK DOESN'T CONTAIN THE VOUCHERS YOU SEEK.",
				"THIS ABNORMALLY LONG TEXT IS HERE AND DESIGNED TO WASTE YOUR TIME AND EFFORT WHILE YOU READ IT.",
			},
			{ "GO TO", "https://youtu.be/p7YXXieghto", "FOR FREE VOUCHERS" },
		},
	},
}
