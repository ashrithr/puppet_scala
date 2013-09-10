class scala::params {
  $scala_version = $::hostname ? {
      default => "2.10.2",
  }
  $scala_base = $::hostname ? {
      default     => "/opt/scala",
  }
}