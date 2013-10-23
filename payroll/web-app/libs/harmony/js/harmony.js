if (console === undefined) {
	var console = {
		log: function() { }
	};
}

if (Toolkit === undefined) {
	var Toolkit = {};
	window.alert("There was a problem loading toolkit.js!");
}

var Harmony = {
	navWidth: "170px",
	navCollapseSpeed: 300,
	navTransitionSpeed: 300,
	useHistory: true,

	/*
		We'll store some various feature detections that are simple and don't
		require Modernizr to test in a "support" object.
	*/
	support: {
		// Check if browser does not support placeholder attribute natively.
		placeholder: !("placeholder" in document.createElement("input"))
	}
};

var History = window.History; // Note: We are using a capital H instead of a lower h

function positionToolTip(tipLauncher, tipBubble)
{
	var tipNotch = tipBubble.find(".tooltip-notch");

	tipNotch.removeClass("top-left");
	tipNotch.removeClass("top-right");
	tipNotch.removeClass("bottom-left");
	tipNotch.removeClass("bottom-right");

	var offset = tipLauncher.position();
	var topAdjust = 0;
	var leftAdjust = 0;

	if (offset.left < window.innerWidth/2)
	{
		leftAdjust = 24;
		if (offset.top < window.innerHeight/2)
		{
			tipNotch.addClass("top-left");
			topAdjust = 24;
		} else {
			tipNotch.addClass("bottom-left");
			topAdjust = (tipBubble.height() + 8) * -1;
		}
	} else {
		leftAdjust = -(tipBubble.width() - 24);
		if (offset.top < window.innerHeight/2)
		{
			tipNotch.addClass("top-right");
			topAdjust = 24;
		} else {
			tipNotch.addClass("bottom-right");
			topAdjust = (tipBubble.height() + 8) * -1;
		}
	}

	tipBubble.css("top", offset.top + topAdjust);
	tipBubble.css("left", offset.left + leftAdjust);
	tipBubble.animate({opacity: 1}, 100);
}

$(window).on(
	"resize",
	function() {
		clearTimeout(resizing);
		var resizing = setTimeout(
			function() {
				var $nav = $("nav").eq(0);
				$nav.find(".primary").eq(0).applyNavScrollFix();
				$nav.find(".secondary").eq(0).applyNavScrollFix();
			},
			500
		);
	}
);

$(document).ready(
	function() {
		var $nav = $("nav").eq(0);
		var $header = $("header").eq(0);
		var $main = $("#main");
		var $page = $("#page");
		var $navDrawer = $nav.children(".nav-drawer").eq(0);
		var $primaryNavHolder = $navDrawer.children(".primary").eq(0);
		var $secondaryNavHolder = $navDrawer.children(".secondary").eq(0);
		var $primaryNav = $primaryNavHolder.find("ul").eq(0);

		$nav.find("a").each(
			function() {
				var $this = $(this);

				// Does this item have a secondary navigation?  If so, give it the "parent" class.
				if ($this.parent("li").children("ul").eq(0).length > 0) {
					$this.addClass("parent");
				}

				$this.on(
					{
						click: function(e) {
							e.preventDefault();

							/*
								Toolkit.loadPage() is a custom page loader.
								It is used to mimic the desired behavior of the Toolkit,
								but it is not intended to be used as reference code.

								Toolkit.loadPage() triggers the "updateNavigation" event
								that handles the display of the current navigation item.

								This custom event was decoupled from the click event in
								order to handle the navigation display when accessing the
								site from a bookmark or on the initial site visit when no
								click event has occurred.
							*/
							var $this = $(this);
							var pageToLoad = $this.attr("href").replace(/^#/, "");


							Harmony.useHistory = false;
							setTimeout(
								function() {
									Harmony.useHistory = true;
								},
								1000
							);

							Toolkit.loadPage(pageToLoad, $this);

							if (pageToLoad && pageToLoad !== "back") {
								// Retrieve the link text to use as the page title
								var pageTitle = $this.text();

								// Update the history with the new page
								History.pushState(null, pageTitle, pageToLoad);
							}
						},
						updateNavigation: function() {
							var $this = $(this);
							var pageToLoad = $this.attr("href").replace(/^#/, "");

							if (pageToLoad === "back") {
								// Show the primary navigation
								$navDrawer.animate(
									{
										left: 0
									},
									Harmony.navTransitionSpeed,
									function() {
										// Remove the secondary navigation
										$secondaryNavHolder.empty();
									}
								);
							}
							else {
								var $currentNavItem = $primaryNav.find("a[href=" + pageToLoad + "]").parent("li");

								if ($currentNavItem.length === 0) {
									$currentNavItem = $this.parent("li");
								}

								// Does this item have a secondary navigation?
								var $secondaryNav = $currentNavItem.children("ul").eq(0);

								// Is this already part of a secondary navigation?
								var $parentNav = $currentNavItem.parents("li").eq(0);

								// Is there a secondary navigation to show?
								if ($secondaryNav.length > 0 || $parentNav.length > 0) {
									var $clonedSecondaryNav = {};

									// Is this a parent with a child?
									if ($secondaryNav.length > 0 && $parentNav.length === 0) {
										// Remove any secondary navigation
										$secondaryNavHolder.empty();

										// Move the secondary navigation into the holder area and show it
										$clonedSecondaryNav = $secondaryNav.clone(true);
										$secondaryNavHolder.append($clonedSecondaryNav);
										$clonedSecondaryNav.show().applyNavScrollFix();

										// Auto-click the first item in the secondary navigation
										$clonedSecondaryNav.find("a").eq(0).trigger("click");
									}

									// Is this a child with a parent?
									else if ($parentNav.length > 0 && $secondaryNav.length === 0) {

										// Is the secondary navigation empty?
										if ($secondaryNavHolder.find("ul").length === 0) {
											$secondaryNavHolder.empty();

											// Move the secondary navigation into the holder area and show it
											var $thisNav = $currentNavItem.parents("ul").eq(0);
											$clonedSecondaryNav = $thisNav.clone(true);
											$secondaryNavHolder.append($clonedSecondaryNav);
											$clonedSecondaryNav.show().applyNavScrollFix();
										}
									}

									// Show the secondary navigation
									$navDrawer.animate(
										{
											left: "-" + Harmony.navWidth
										},
										Harmony.navTransitionSpeed
									);
								}
								// No secondary navigation found
								else {
									// Show the primary navigation
									$navDrawer.animate(
										{
											left: 0
										},
										Harmony.navTransitionSpeed,
										function() {
											// Remove the secondary navigation
											$secondaryNavHolder.empty();
										}
									);
								}

								// Show the current page as selected
								$navDrawer.find(".selected").removeClass("selected");
								$navDrawer.find("a[href=" + pageToLoad + "]").addClass("selected");
							}
						}
					}
				);
			}
		);

		$primaryNavHolder.applyNavScrollFix();
		$secondaryNavHolder.applyNavScrollFix();

		$("header").find("a").on(
			"click",
			function(e) {
				e.preventDefault();

				if ($nav.data("collapsed") === true) {
					// Expand navigation
					$nav.animate(
						{
							left: 0
						},
						Harmony.navCollapseSpeed
					).data("collapsed", false);
					$header.add($main).animate(
						{
							marginLeft: Harmony.navWidth
						},
						Harmony.navCollapseSpeed
					);
				}
				else {
					// Collapse navigation
					$nav.animate(
						{
							left: "-" + Harmony.navWidth
						},
						Harmony.navCollapseSpeed
					).data("collapsed", true);
					$header.add($main).animate(
						{
							marginLeft: 0
						},
						Harmony.navCollapseSpeed
					);
				}
			}
		);

		/*
			These pages are loaded dynamically, so the elements won't necessarily
			exist on the page when the intial DOM ready event fires.
			Instead, we are firing a "pageLoaded" event each time a new page is
			loaded into the DOM, so we'll bind to that.
		*/
		$page.on(
			"pageLoaded",
			function() {
				// IE9 support for custom checkboxes and radio buttons
				if ($.browser.msie) {
					$("input[type=checkbox]").wrap("<div class='checkbox' />");
					$("input[type=radio]").wrap("<div class='radio' />");

					$("input[type=checkbox]").on(
						"change",
						function(){
							if($(this).is(":checked")) {
								$(this).parent().addClass("checked");
							} else {
								$(this).parent().removeClass("checked");
							}
					});

					$("input[type=radio]").on(
						"click",
						function(e){
							e.preventDefault();
							var groupName = $(this).attr("name");
							$("input[name=" + groupName + "]").parent().removeClass("checked");
							$(this).parent().addClass("checked");
					});
				}

				// Page: controls-scrollbars
				$("#controls-scrollbars").find(".scrollable").tinyscrollbar();

				// Page: page-elements-drawers
				$("#page-elements-drawers").find(".scrollable").tinyscrollbar();

				// Page: interaction-patterns-lazy-loading
				$(".infinite-loader").on(
					"start",
					function() {
						clearInterval(Harmony.lazyLoader);
						var loader = this;
						var frameWidth = 150;
						var frameRate = 100;
						var counter = 0;
						var looping = false;
						var loopRow = 0;

						Harmony.lazyLoader = setInterval(
							function() {
								if (counter === 6) {
									looping = true;
									counter = 0;
								}
								if (looping) {
									loopRow = "-130px";
								}
								loader.style.backgroundPosition = (frameWidth * counter * -1) + "px " + loopRow;
								counter++;
							},
							frameRate
						);
					}
				).on(
					"stop",
					function() {
						clearInterval(Harmony.lazyLoader);
						this.style.backgroundPosition = "0 0";
					}
				);

				// Page: controls-dropdowns
				$(".select").each(
					function() {
						var $this = $(this);
						var $select = $this.find("select").eq(0);
						var $options = $select.children("option");
						var optionsLength = $options.length;
						var selectedOptionIndex = $select[0].selectedIndex;
						var $selectedOption = $options.eq(selectedOptionIndex);
						var selectedOptionText = $selectedOption.text();

						// Build the markup that will mimic the SELECT and OPTION elements
						var $fauxSelect = $("<span/>",
							{
								text: selectedOptionText
							}
						);

						var $fauxOptionBlock = $("<ul/>");
						var $fauxOptionItems = [];
						for (var i = 0; i < optionsLength; i++) {
							$fauxOptionItems.push(
								$("<li/>",
									{
										"data-index": i,
										text: $options[i].text,
										// JSLint: Supress warnings about looped function declarations.
										/*jshint loopfunc: true */
										click: function(e) {
											e.stopPropagation();
											var $this = $(this);
											var optionValue = $this.text();
											var optionIndex = $this.data("index");

											$fauxSelect.text(optionValue);
											$(".select").removeClass("open");

											$select[0].selectedIndex = optionIndex;
										}
									}
								)
							);
						}
						$fauxOptionBlock.append($fauxOptionItems);

						// Add the new elements to the page
						$this.append($fauxSelect, $fauxOptionBlock);

						// Hide the "real" SELECT element
						$select.addClass("hidden");

						$this.on(
							"click",
							function(e){
								e.preventDefault();
								var $this = $(this);
								// Show/hide the options
								if ($this.hasClass("open")) {
									$this.removeClass("open");
								}
								else {
									$this.addClass("open");
								}
							}
						);
					}
				);

				// Page: global-elements-form-fields
				$("input[type=text]").each(
					function() {
						var $this = $(this);
						var placeholderText = $this.attr("placeholder");

						// Check if browser does not support placeholder attribute natively.
						if (Harmony.support.placeholder) {
							if ($this.val() === "") {
								$this.val(placeholderText).addClass("empty");
							}

							$this.on(
								"focus",
								function() {
									if ($this.val() === placeholderText) {
										$this.val("").addClass("focused");
									}
								}
							).on(
								"blur",
								function() {
									if ($this.val() === "") {
										$this.val(placeholderText).addClass("blurred");
									}
								}
							);
						}
					}
				);

				// Page: global-elements-tables

				function styleCheckedRows() {
					$("input[type=checkbox]").parents("tr").removeClass("checked");
					$("input:checked").parents("tr").addClass("checked");
				}

				$("table input[type=checkbox]").click(function(e){
					if (!$(this).prop("checked")) {
						$(this).parents("table").find("th input[type=checkbox]").prop("checked", false);
					}
					styleCheckedRows();
					e.stopPropagation();
				});

				$("table tr").click(function(){
					if ($(this).children("td").length > 0)
					{
						$(this).find("input[type=checkbox]").click();
						if (!$(this).find("input[type=checkbox]").prop("checked")) {
							$(this).parents("table").find("th input[type=checkbox]").prop("checked", false);
						}
						styleCheckedRows();
					}
				});

				$("table th input[type=checkbox]").click(function() {
					var $localCheckboxes = $(this).parents("table");
					if ($(this).prop("checked")) {
						$localCheckboxes.find("input[type=checkbox]").prop("checked", true);
						$localCheckboxes.find(".checkbox").addClass("checked");
					} else {
						$localCheckboxes.find("input[type=checkbox]").prop("checked", false);
						$localCheckboxes.find(".checkbox").removeClass("checked");
					}
					styleCheckedRows();
				});

				$(".section-header").click(function(e){
					$(this).nextUntil(".section-header").toggle();
					$(this).toggleClass("open");
					e.stopPropagation();
				});

				// Page: global-elements-media-lightbox
				$("body > .lightbox").remove();
				$(".lightbox").insertAfter($("#main"));

				$(".close-lightbox").click(function(e){
					e.preventDefault();
					$(this).parents(".lightbox").fadeOut(100);
				});

				$(".open-lightbox").click(function(e){
					e.preventDefault();
					$(".lightbox").fadeIn(100);
				});

				// Page: page-types-modal-overlays
				$("body > .modal-overlay").remove();
				$(".modal-overlay").insertAfter($("#main"));

				$(".open-modal").click(function(e){
					e.preventDefault();
					$(".modal-overlay").fadeIn(100);
				});

				$(".close-modal").click(function(e){
					e.preventDefault();
					$(this).parents(".modal-overlay").fadeOut(100);
				});

				// Page: interaction-patterns-tooltip
				$(".showtip1").mouseover(function(){
					var tl = $(".showtip1");
					var tb = $(".tip1");
					positionToolTip(tl, tb);
				});

				$(".showtip2").mouseover(function(){
					var tl = $(".showtip2");
					var tb = $(".tip2");
					positionToolTip(tl, tb);
				});

				$(".showtip").mouseout(function(){
					$(".tooltip").animate({opacity: 0}, 100);
				});

				// Page: interaction-patterns-auto-suggest
				$(".typeahead").each(function(){

					// Create an array of values from the input's 'data-source' attribute
					// and fill the suggest list with all items. They are all hidden initially.
					// We will reveal the ones that match the search term.

					var allValues = $(this).find("input").data("source");
					for (var i = 0; i < allValues.length; i++) {
						$(this).find("ul").append("<li>" + allValues[i] + "</li>");
					}
				});

				$(".typeahead input").keyup(function(){

					var termTemplate = "<b>%s</b>";
					var strToMatch = $(this).val();
					strToMatch = strToMatch.toLowerCase();

					var addLabel = "Add " + strToMatch;

					$(this).parent().find(".addTerm").text(addLabel);

					if (strToMatch.length < $(this).data("trigger"))
					{
						$(this).parent().find("ul,.flyout").hide();
					} else {
						$(this).parent().find("li").each(function(){
							// Don't hide the permanent "Add .." li when we hide the others
							$(this).not(".addTerm").hide();
							var str = $(this).text();
							if (str.toLowerCase().indexOf(strToMatch) >= 0)
							{
								var matchStart = str.toLowerCase().indexOf(strToMatch);
								$(this).parents("ul,.flyout").show();
								$(this).show();
								// Before we style the searched term, let's replace it with the
								// case of all matches.
								var styledMatch = str.charAt(matchStart) + strToMatch.substr(1, strToMatch.length-1);
								var styledTerm = termTemplate.replace("%s", styledMatch);
								var fullTerm = $(this);
								fullTerm.html(fullTerm.text().replace(styledMatch, styledTerm));
							}

							if ($(this).parent().find("li").length === $(this).parent().find("li:hidden").length) {
								$(this).parents("ul,.flyout").hide();
							}
						});
					}
				});

				$(".typeahead li").click(function(){
					$(this).parents("ul,.flyout").hide();
					var $local = $(this).parents(".typeahead");
					$local.find("input").val($(this).text());
				});
				
				$("input.auto-kal").each(
					function() {
						var $this = $(this);
						var optionsRaw = $this.data("kal");
						// JSLint: Supress warnings about the use of eval. eval is evil.
						/*jshint evil: true */
						// The following function constructor is eval. However, the following line is borrowed from the initialization method in kalendae.js.
						var options = (optionsRaw === null || optionsRaw === "") ? {} : (new Function('return {' + optionsRaw + '};'))();
						$this.kalendae(options);
					}
				);
			}
		); // end "pageLoaded" event
	}
);  // End ready

/* !jQuery Plugins */
(function($) {
	$.fn.extend(
		{
			// plugin to fix the scrolling in the left navigation
			applyNavScrollFix: function() {
				var docHeight = $(document).height();
				var navOffsetTop = this.offset().top;
				this.height(docHeight - navOffsetTop);
				this.tinyscrollbar();
				return this;
			}
		}
	);
})(jQuery);
