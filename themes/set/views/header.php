<!DOCTYPE html>
<html>
<head>
	 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><?php echo html::specialchars($page_title.$site_name); ?></title>
	<?php if (!Kohana::config('settings.enable_timeline')) { ?>
		<style type="text/css">
			#graph{display:none;}
			#map{height:480px;}
		</style>
	<?php } ?>
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> -->
	<?php echo $header_block; ?>
	<?php
	// Action::header_scripts - Additional Inline Scripts from Plugins
	Event::run('ushahidi_action.header_scripts');
	?>

</head>

<?php
  // Add a class to the body tag according to the page URI

  // we're on the home page
  if (count($uri_segments) == 0)
  {
  	$body_class = "page-main";
  }
  // 1st tier pages
  elseif (count($uri_segments) == 1)
  {
    $body_class = "page-".$uri_segments[0];
  }
  // 2nd tier pages... ie "/reports/submit"
  elseif (count($uri_segments) >= 2)
  {
    $body_class = "page-".$uri_segments[0]."-".$uri_segments[1];
  }
?>

<body id="page" class="<?php echo $body_class; ?>">

	<?php echo $header_nav; ?>

	<!-- wrapper -->
	<div class="rapidxwpr floatholder test">

		<!-- header -->
		<div id="header">
					<!-- logo -->
						<?php if ($banner == NULL): ?>
						<div id="logo">
							<h1><a href="<?php echo url::site();?>"><?php echo $site_name; ?></a></h1>
							<span><?php echo $site_tagline; ?></span>
						</div>
						<?php else: ?>
						<div id="logo">
							<a href="<?php echo url::site();?>"><img src="<?php echo $banner; ?>" alt="<?php echo $site_name; ?>" /></a>
						</div>
						<?php endif; ?>
					<!-- / logo -->
				<!-- mainmenu -->
				<div id="mainmenu" class="clearingfix">
					<ul>
						<?php nav::main_tabs($this_page); ?>
					</ul>

					<?php if ($allow_feed == 1) { ?>
					<!-- <div style="float:right;"><a href="<?php echo url::site(); ?>feed/"><img alt="<?php echo htmlentities(Kohana::lang('ui_main.rss'), ENT_QUOTES); ?>" src="<?php echo url::file_loc('img'); ?>media/img/icon-feed.png" style="vertical-align: middle;" border="0" /></a></div> -->
					<?php } ?>

				</div>
				<!-- / mainmenu -->
		</div>
		<div class="blocksubmenu">
			<div style="float:left;margin-left:10px;"><a href="http://www.sanitationhackathon.org/" target="_blank"><img alt="Sanitation Hackathon" src="<?php echo url::file_loc('img'); ?>media/img/sanhack.png" width="112" style="vertical-align: middle;" border="0" /></a></div>
			<!-- submit incident -->
			<?php echo $submit_btn; ?>
			<!-- / submit incident -->
			<!-- searchbox -->
			<div id="searchbox">

				<!-- languages -->
				<?php echo $languages;?>
				<!-- / languages -->

				<!-- searchform -->
				<?php echo $search; ?>
				<!-- / searchform -->
			</div> 
			<!-- / searchbox -->
		

		</div>
		<!-- / header -->
        <!-- / header item for plugins -->
        <?php
            // Action::header_item - Additional items to be added by plugins
	        Event::run('ushahidi_action.header_item');
        ?>

		<!-- main body -->
		<div id="middle">
			<div class="background layoutleft">

			
