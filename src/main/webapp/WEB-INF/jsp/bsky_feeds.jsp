<%--
  Created by IntelliJ IDEA.
  User: jthota
  Date: 11/24/2025
  Time: 4:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="bluesky-feed-wrapper">
  <h4>Latest from Bluesky</h4>
  <div class="bluesky-feed-preview">
    <div class="bluesky-profile-link">
      <a href="https://bsky.app/profile/scge.bsky.social" target="_blank" class="bluesky-link">
        <i class="fab fa-bluesky"></i> @scge.bsky.social
      </a>
    </div>
<%--    <p class="bluesky-description">--%>
<%--      Follow us on Bluesky for the latest updates on the Somatic Cell Genome Editing Consortium,--%>
<%--      research highlights, and news from the gene editing community.--%>
<%--    </p>--%>

    <div class="bluesky-posts-container">
      <blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:dinjynbbn4gwctbpyptaynjf/app.bsky.feed.post/3m65ngsl6fs2o" data-bluesky-cid="bafyreib2ipfptkuwjxlawpdcik53rfvup2vzjz43rmie6n43lax5ggyfe4" data-bluesky-embed-color-mode="system"><p lang="en">Are you at the @asgct.bsky.social Breakthroughs in Targeted In Vivo Gene Editing event? Hear from these SCGE researchers on Friday:

        Sonia Vallabh, &quot;AAV-mediated epigenetic editing for prion disease&quot; (1/3)<br><br><a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngsl6fs2o?ref_src=embed">[image or embed]</a></p>&mdash; SCGE (<a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf?ref_src=embed">@scge.bsky.social</a>) <a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngsl6fs2o?ref_src=embed">November 21, 2025 at 9:56 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>
      <blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:dinjynbbn4gwctbpyptaynjf/app.bsky.feed.post/3m65ngttbmc2o" data-bluesky-cid="bafyreifcmalkx2vuzwhyfk2lehmvy3ydrpabv3feq774oga5q7nn5glkgm" data-bluesky-embed-color-mode="system"><p lang="en">Rebecca Ahrens-Nicklas, &quot;Personalized liver-directed corrective gene editing&quot; (2/3)<br><br><a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngttbmc2o?ref_src=embed">[image or embed]</a></p>&mdash; SCGE (<a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf?ref_src=embed">@scge.bsky.social</a>) <a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngttbmc2o?ref_src=embed">November 21, 2025 at 9:56 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>
      <blockquote class="bluesky-embed" data-bluesky-uri="at://did:plc:dinjynbbn4gwctbpyptaynjf/app.bsky.feed.post/3m65ngv5dcs2o" data-bluesky-cid="bafyreibydwwqogyzxerqk3ewamwlwqnjyecxxsjfcf5qwtfbsnqzo3s4my" data-bluesky-embed-color-mode="system"><p lang="en">Kiran Musunuru and Sonia Vallabh, panelists on &quot;Concluding Panel: The Future of Targeted In Vivo Gene Editing&quot; (3/3)<br><br><a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngv5dcs2o?ref_src=embed">[image or embed]</a></p>&mdash; SCGE (<a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf?ref_src=embed">@scge.bsky.social</a>) <a href="https://bsky.app/profile/did:plc:dinjynbbn4gwctbpyptaynjf/post/3m65ngv5dcs2o?ref_src=embed">November 21, 2025 at 9:56 AM</a></blockquote><script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>
    </div>

    <script async src="https://embed.bsky.app/static/embed.js" charset="utf-8"></script>

    <div class="bluesky-rotation-controls">
      <button class="rotation-btn" id="prevPost"><i class="fas fa-chevron-left"></i></button>
      <div class="rotation-indicator">
        <span id="currentPost">1</span> / <span id="totalPosts">3</span>
      </div>
      <button class="rotation-btn" id="nextPost"><i class="fas fa-chevron-right"></i></button>
    </div>

    <a href="https://bsky.app/profile/scge.bsky.social" target="_blank" class="btn btn-primary btn-block bluesky-view-btn">
      View Posts on Bluesky
    </a>
  </div>

</div>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Wait for Bluesky embeds to load
    setTimeout(function() {
      const postsContainer = document.querySelector('.bluesky-posts-container');

      // Check if the container exists (only on home page)
      if (!postsContainer) return;

      const posts = postsContainer.querySelectorAll('.bluesky-embed');
      const currentPostSpan = document.getElementById('currentPost');
      const totalPostsSpan = document.getElementById('totalPosts');
      const prevBtn = document.getElementById('prevPost');
      const nextBtn = document.getElementById('nextPost');

      // Check if we have posts and controls
      if (!posts.length || !currentPostSpan || !totalPostsSpan || !prevBtn || !nextBtn) {
        console.log('Bluesky rotation: Missing elements', {
          posts: posts.length,
          hasCurrentSpan: !!currentPostSpan,
          hasTotalSpan: !!totalPostsSpan,
          hasPrevBtn: !!prevBtn,
          hasNextBtn: !!nextBtn
        });
        return;
      }

      console.log('Bluesky rotation initialized with', posts.length, 'posts');

      let currentIndex = 0;
      const autoRotateInterval = 8000; // 8 seconds
      let autoRotateTimer;

      // Set total posts
      totalPostsSpan.textContent = posts.length;

      // Hide all posts except the first one
      function showPost(index) {
        console.log('Showing post', index + 1);
        posts.forEach((post, i) => {
          post.classList.remove('active');
        });
        posts[index].classList.add('active');
        currentPostSpan.textContent = index + 1;
      }

      // Next post
      function nextPost() {
        currentIndex = (currentIndex + 1) % posts.length;
        showPost(currentIndex);
        resetAutoRotate();
      }

      // Previous post
      function prevPost() {
        currentIndex = (currentIndex - 1 + posts.length) % posts.length;
        showPost(currentIndex);
        resetAutoRotate();
      }

      // Auto rotate
      function startAutoRotate() {
        console.log('Starting auto-rotate');
        autoRotateTimer = setInterval(nextPost, autoRotateInterval);
      }

      function resetAutoRotate() {
        console.log('Resetting auto-rotate');
        clearInterval(autoRotateTimer);
        startAutoRotate();
      }

      // Event listeners
      nextBtn.addEventListener('click', function() {
        console.log('Next button clicked');
        nextPost();
      });

      prevBtn.addEventListener('click', function() {
        console.log('Previous button clicked');
        prevPost();
      });

      // Initialize - remove active from all, then add to first
      posts.forEach(post => post.classList.remove('active'));
      posts[0].classList.add('active');
      console.log('First post set as active');
      startAutoRotate();

      // Pause auto-rotate on hover
      postsContainer.addEventListener('mouseenter', function() {
        console.log('Pausing auto-rotate (hover)');
        clearInterval(autoRotateTimer);
      });

      postsContainer.addEventListener('mouseleave', function() {
        console.log('Resuming auto-rotate (leave)');
        startAutoRotate();
      });
    }, 2000); // Wait 2 seconds for Bluesky embeds to load
  });
</script>

<style>
  .bluesky-feed-wrapper {
    margin-top: 30px;
    margin-bottom: 30px;
  }

  .bluesky-feed-wrapper h4 {
    margin-bottom: 15px;
  }

  .bluesky-feed-preview {
    background: #ffffff;
    border: 1px solid #e1e8ed;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  }

  .bluesky-profile-link {
    margin-bottom: 15px;
  }

  .bluesky-link {
    font-size: 18px;
    font-weight: 600;
    color: #1185fe;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }

  .bluesky-link:hover {
    color: #0d6efd;
    text-decoration: underline;
  }

  .bluesky-link i {
    font-size: 20px;
  }

  .bluesky-description {
    color: #666;
    font-size: 14px;
    line-height: 1.6;
    margin-bottom: 15px;
  }

  .bluesky-posts-container {
    margin: 20px 0;
    min-height: 500px;
    position: relative;
    overflow: hidden;
  }

  .bluesky-posts-container .bluesky-embed {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.5s ease, visibility 0.5s ease;
    pointer-events: none;
    z-index: 1;
  }

  .bluesky-posts-container .bluesky-embed.active {
    opacity: 1 !important;
    visibility: visible !important;
    pointer-events: auto !important;
    z-index: 10 !important;
  }

  .bluesky-rotation-controls {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    margin: 15px 0;
  }

  .rotation-btn {
    background: #1185fe;
    border: none;
    color: white;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    font-size: 14px;
  }

  .rotation-btn:hover {
    background: #0d6efd;
    transform: scale(1.1);
    box-shadow: 0 4px 12px rgba(17, 133, 254, 0.3);
  }

  .rotation-btn:active {
    transform: scale(0.95);
  }

  .rotation-indicator {
    font-size: 14px;
    font-weight: 600;
    color: #666;
    min-width: 50px;
    text-align: center;
  }

  .bluesky-view-btn {
    background-color: #1185fe;
    border-color: #1185fe;
    color: white;
    font-weight: 600;
    padding: 10px;
    border-radius: 8px;
    transition: all 0.3s ease;
    margin-top: 15px;
  }

  .bluesky-view-btn:hover {
    background-color: #0d6efd;
    border-color: #0d6efd;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(17, 133, 254, 0.3);
  }
</style>
